import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

// typedef FutureOr<Iterable<T>> SuggestionsCallback<T>(String pattern);
typedef Widget ItemBuilder<T>(BuildContext context, T itemData);
typedef void SuggestionSelectionCallback<T>(T suggestion);
typedef Widget ErrorBuilder(BuildContext context, Object? error);

typedef AnimationTransitionBuilder(
    BuildContext context, Widget child, AnimationController? controller);

class FilterTextField<T> extends StatefulWidget {
  // final SuggestionsCallback<T> suggestionsCallback;
  final Iterable<T> items;
  final SuggestionSelectionCallback<T> onSuggestionSelected;
  final ItemBuilder<T> itemBuilder;
  final SuggestionsBoxDecoration suggestionsBoxDecoration;
  final SuggestionsBoxController? suggestionsBoxController;
  final Duration debounceDuration;
  final WidgetBuilder? loadingBuilder;
  final WidgetBuilder? noItemsFoundBuilder;
  final ErrorBuilder? errorBuilder;
  final AnimationTransitionBuilder? transitionBuilder;
  final Duration animationDuration;
  final AxisDirection direction;
  final double animationStart;
  final FilterTextFieldConfiguration textFieldConfiguration;
  final double suggestionsBoxVerticalOffset;
  final bool getImmediateSuggestions;
  final bool hideOnLoading;
  final bool hideOnEmpty;
  final bool hideOnError;
  final bool hideSuggestionsOnKeyboardHide;
  final bool keepSuggestionsOnLoading;
  final bool keepSuggestionsOnSuggestionSelected;
  final bool autoFlipDirection;
  final bool hideKeyboard;

  FilterTextField(
      {Key? key,
      // required this.suggestionsCallback,
      required this.items,
      required this.itemBuilder,
      required this.onSuggestionSelected,
      this.textFieldConfiguration: const FilterTextFieldConfiguration(),
      this.suggestionsBoxDecoration: const SuggestionsBoxDecoration(),
      this.debounceDuration: const Duration(milliseconds: 500),
      this.suggestionsBoxController,
      this.loadingBuilder,
      this.noItemsFoundBuilder,
      this.errorBuilder,
      this.transitionBuilder,
      this.animationStart: 0.25,
      this.animationDuration: const Duration(milliseconds: 500),
      this.getImmediateSuggestions: false,
      this.suggestionsBoxVerticalOffset: 5.0,
      this.direction: AxisDirection.down,
      this.hideOnLoading: false,
      this.hideOnEmpty: false,
      this.hideOnError: false,
      this.hideSuggestionsOnKeyboardHide: true,
      this.keepSuggestionsOnLoading: true,
      this.keepSuggestionsOnSuggestionSelected: false,
      this.autoFlipDirection: false,
      this.hideKeyboard: false})
      : assert(animationStart >= 0.0 && animationStart <= 1.0),
        assert(
            direction == AxisDirection.down || direction == AxisDirection.up),
        super(key: key);

  @override
  _FilterTextFieldState<T> createState() => _FilterTextFieldState<T>();
}

class _FilterTextFieldState<T> extends State<FilterTextField<T>> with WidgetsBindingObserver {

  FocusNode? _focusNode;
  TextEditingController? _textEditingController;
  _SuggestionsBox? _suggestionsBox;

  TextEditingController? get _effectiveController =>
      widget.textFieldConfiguration.controller ?? _textEditingController;

  FocusNode? get _effectiveFocusNode =>
      widget.textFieldConfiguration.focusNode ?? _focusNode;
  late VoidCallback _focusNodeListener;

  final LayerLink _layerLink = LayerLink();

  // Timer that resizes the suggestion box on each tick. Only active when the user is scrolling.
  Timer? _resizeOnScrollTimer;

  // The rate at which the suggestion box will resize when the user is scrolling
  final Duration _resizeOnScrollRefreshRate = const Duration(milliseconds: 500);

  // Will have a value if the typeahead is inside a scrollable widget
  ScrollPosition? _scrollPosition;

  // Keyboard detection
  final Stream<bool> _keyboardVisibility =
      KeyboardVisibilityController().onChange;
  late StreamSubscription<bool> _keyboardVisibilitySubscription;

  @override
  void didChangeMetrics() {
    // Catch keyboard event and orientation change; resize suggestions list
    this._suggestionsBox!.onChangeMetrics();
  }

  @override
  void dispose() {
    this._suggestionsBox!.close();
    this._suggestionsBox!.widgetMounted = false;
    WidgetsBinding.instance!.removeObserver(this);
    _keyboardVisibilitySubscription.cancel();
    _effectiveFocusNode!.removeListener(_focusNodeListener);
    _focusNode?.dispose();
    _resizeOnScrollTimer?.cancel();
    _scrollPosition?.removeListener(_scrollResizeListener);
    _textEditingController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);

    if (widget.textFieldConfiguration.controller == null) {
      this._textEditingController = TextEditingController();
    }

    if (widget.textFieldConfiguration.focusNode == null) {
      this._focusNode = FocusNode();
    }

    this._suggestionsBox =
        _SuggestionsBox(context, widget.direction, widget.autoFlipDirection);
    widget.suggestionsBoxController?._suggestionsBox = this._suggestionsBox;
    widget.suggestionsBoxController?._effectiveFocusNode =
        this._effectiveFocusNode;

    this._focusNodeListener = () {
      if (_effectiveFocusNode!.hasFocus) {
        this._suggestionsBox!.open();
      } else {
        this._suggestionsBox!.close();
      }
    };

    this._effectiveFocusNode!.addListener(_focusNodeListener);

    // hide suggestions box on keyboard closed
    this._keyboardVisibilitySubscription =
        _keyboardVisibility.listen((bool isVisible) {
      if (widget.hideSuggestionsOnKeyboardHide && !isVisible) {
        _effectiveFocusNode!.unfocus();
      }
    });

    WidgetsBinding.instance!.addPostFrameCallback((duration) {
      if (mounted) {
        this._initOverlayEntry();
        // calculate initial suggestions list size
        this._suggestionsBox!.resize();

        // in case we already missed the focus event
        if (this._effectiveFocusNode!.hasFocus) {
          this._suggestionsBox!.open();
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ScrollableState? scrollableState = Scrollable.of(context);
    if (scrollableState != null) {
      // The TypeAheadField is inside a scrollable widget
      _scrollPosition = scrollableState.position;

      _scrollPosition!.removeListener(_scrollResizeListener);
      _scrollPosition!.isScrollingNotifier.addListener(_scrollResizeListener);
    }
  }

  void _scrollResizeListener() {
    bool isScrolling = _scrollPosition!.isScrollingNotifier.value;
    _resizeOnScrollTimer?.cancel();
    if (isScrolling) {
      // Scroll started
      _resizeOnScrollTimer =
          Timer.periodic(_resizeOnScrollRefreshRate, (timer) {
        _suggestionsBox!.resize();
      });
    } else {
      // Scroll finished
      _suggestionsBox!.resize();
    }
  }

  void _initOverlayEntry() {
    this._suggestionsBox!._overlayEntry = OverlayEntry(builder: (context) {
      final suggestionsList = _SuggestionsList<T>(
        suggestionsBox: _suggestionsBox,
        decoration: widget.suggestionsBoxDecoration,
        debounceDuration: widget.debounceDuration,
        controller: this._effectiveController,
        loadingBuilder: widget.loadingBuilder,
        noItemsFoundBuilder: widget.noItemsFoundBuilder,
        errorBuilder: widget.errorBuilder,
        transitionBuilder: widget.transitionBuilder,
        items: widget.items,
        // suggestionsCallback: widget.suggestionsCallback,
        animationDuration: widget.animationDuration,
        animationStart: widget.animationStart,
        getImmediateSuggestions: widget.getImmediateSuggestions,
        onSuggestionSelected: (T selection) {
          if (!widget.keepSuggestionsOnSuggestionSelected) {
            this._effectiveFocusNode!.unfocus();
            this._suggestionsBox!.close();
          }
          widget.onSuggestionSelected(selection);
        },
        itemBuilder: widget.itemBuilder,
        direction: _suggestionsBox!.direction,
        hideOnLoading: widget.hideOnLoading,
        hideOnEmpty: widget.hideOnEmpty,
        hideOnError: widget.hideOnError,
        keepSuggestionsOnLoading: widget.keepSuggestionsOnLoading,
      );

      double w = _suggestionsBox!.textBoxWidth;
      if (widget.suggestionsBoxDecoration.constraints != null) {
        if (widget.suggestionsBoxDecoration.constraints!.minWidth != 0.0 &&
            widget.suggestionsBoxDecoration.constraints!.maxWidth !=
                double.infinity) {
          w = (widget.suggestionsBoxDecoration.constraints!.minWidth +
                  widget.suggestionsBoxDecoration.constraints!.maxWidth) /
              2;
        } else if (widget.suggestionsBoxDecoration.constraints!.minWidth !=
                0.0 &&
            widget.suggestionsBoxDecoration.constraints!.minWidth > w) {
          w = widget.suggestionsBoxDecoration.constraints!.minWidth;
        } else if (widget.suggestionsBoxDecoration.constraints!.maxWidth !=
                double.infinity &&
            widget.suggestionsBoxDecoration.constraints!.maxWidth < w) {
          w = widget.suggestionsBoxDecoration.constraints!.maxWidth;
        }
      }

      return Positioned(
        width: w,
        child: CompositedTransformFollower(
          link: this._layerLink,
          showWhenUnlinked: false,
          offset: Offset(
              widget.suggestionsBoxDecoration.offsetX,
              _suggestionsBox!.direction == AxisDirection.down
                  ? _suggestionsBox!.textBoxHeight +
                      widget.suggestionsBoxVerticalOffset
                  : _suggestionsBox!.directionUpOffset),
          child: _suggestionsBox!.direction == AxisDirection.down
              ? suggestionsList
              : FractionalTranslation(
                  translation:
                      Offset(0.0, -1.0), // visually flips list to go up
                  child: suggestionsList,
                ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: this._layerLink,
      child: TextField(
        focusNode: this._effectiveFocusNode,
        controller: this._effectiveController,
        decoration: widget.textFieldConfiguration.decoration,
        style: widget.textFieldConfiguration.style,
        textAlign: widget.textFieldConfiguration.textAlign,
        enabled: widget.textFieldConfiguration.enabled,
        keyboardType: widget.textFieldConfiguration.keyboardType,
        autofocus: widget.textFieldConfiguration.autofocus,
        inputFormatters: widget.textFieldConfiguration.inputFormatters,
        autocorrect: widget.textFieldConfiguration.autocorrect,
        maxLines: widget.textFieldConfiguration.maxLines,
        minLines: widget.textFieldConfiguration.minLines,
        maxLength: widget.textFieldConfiguration.maxLength,
        // ignore: deprecated_member_use
        maxLengthEnforced: widget.textFieldConfiguration.maxLengthEnforced,
        obscureText: widget.textFieldConfiguration.obscureText,
        onChanged: widget.textFieldConfiguration.onChanged,
        onSubmitted: widget.textFieldConfiguration.onSubmitted,
        onEditingComplete: widget.textFieldConfiguration.onEditingComplete,
        onTap: widget.textFieldConfiguration.onTap,
        scrollPadding: widget.textFieldConfiguration.scrollPadding,
        textInputAction: widget.textFieldConfiguration.textInputAction,
        textCapitalization: widget.textFieldConfiguration.textCapitalization,
        keyboardAppearance: widget.textFieldConfiguration.keyboardAppearance,
        cursorWidth: widget.textFieldConfiguration.cursorWidth,
        cursorRadius: widget.textFieldConfiguration.cursorRadius,
        cursorColor: widget.textFieldConfiguration.cursorColor,
        textDirection: widget.textFieldConfiguration.textDirection,
        enableInteractiveSelection:
            widget.textFieldConfiguration.enableInteractiveSelection,
        readOnly: widget.hideKeyboard,
      ),
    );
  }
}

class _SuggestionsList<T> extends StatefulWidget {
  final _SuggestionsBox? suggestionsBox;
  final TextEditingController? controller;
  final bool getImmediateSuggestions;
  final SuggestionSelectionCallback<T>? onSuggestionSelected;
  // final SuggestionsCallback<T>? suggestionsCallback;
  final Iterable<T>? items;
  final ItemBuilder<T>? itemBuilder;
  final SuggestionsBoxDecoration? decoration;
  final Duration? debounceDuration;
  final WidgetBuilder? loadingBuilder;
  final WidgetBuilder? noItemsFoundBuilder;
  final ErrorBuilder? errorBuilder;
  final AnimationTransitionBuilder? transitionBuilder;
  final Duration? animationDuration;
  final double? animationStart;
  final AxisDirection? direction;
  final bool? hideOnLoading;
  final bool? hideOnEmpty;
  final bool? hideOnError;
  final bool? keepSuggestionsOnLoading;

  _SuggestionsList({
    required this.suggestionsBox,
    this.controller,
    this.getImmediateSuggestions: false,
    this.onSuggestionSelected,
    this.items,
    // this.suggestionsCallback,
    this.itemBuilder,
    this.decoration,
    this.debounceDuration,
    this.loadingBuilder,
    this.noItemsFoundBuilder,
    this.errorBuilder,
    this.transitionBuilder,
    this.animationDuration,
    this.animationStart,
    this.direction,
    this.hideOnLoading,
    this.hideOnEmpty,
    this.hideOnError,
    this.keepSuggestionsOnLoading,
  });

  @override
  _SuggestionsListState<T> createState() => _SuggestionsListState<T>();
}

class _SuggestionsListState<T> extends State<_SuggestionsList<T>>
    with SingleTickerProviderStateMixin {
  Iterable<T>? _suggestions;
  late bool _suggestionsValid;
  late VoidCallback _controllerListener;
  Timer? _debounceTimer;
  bool? _isLoading, _isQueued;
  Object? _error;
  AnimationController? _animationController;
  String? _lastTextValue;
  late final _scrollController = ScrollController();

  _SuggestionsListState() {
    this._controllerListener = () {
      // If we came here because of a change in selected text, not because of
      // actual change in text
      if (widget.controller!.text == this._lastTextValue) return;

      this._lastTextValue = widget.controller!.text;

      this._debounceTimer?.cancel();
      this._debounceTimer = Timer(widget.debounceDuration!, () async {
        if (this._debounceTimer!.isActive) return;
        if (_isLoading!) {
          _isQueued = true;
          return;
        }

        await this.invalidateSuggestions();
        while (_isQueued!) {
          _isQueued = false;
          await this.invalidateSuggestions();
        }
      });
    };
  }

  @override
  void didUpdateWidget(_SuggestionsList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.controller!.addListener(this._controllerListener);
    _getSuggestions();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getSuggestions();
  }

  @override
  void initState() {
    super.initState();

    this._animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    this._suggestionsValid = false;
    this._isLoading = false;
    this._isQueued = false;
    this._lastTextValue = widget.controller!.text;

    if (widget.getImmediateSuggestions) {
      this._getSuggestions();
    }

    widget.controller!.addListener(this._controllerListener);
  }

  Future<void> invalidateSuggestions() async {
    _suggestionsValid = false;
    await _getSuggestions();
  }

  Future<void> _getSuggestions() async {
    if (_suggestionsValid) return;
    _suggestionsValid = true;

    if (mounted) {
      setState(() {
        this._animationController!.forward(from: 1.0);

        this._isLoading = true;
        this._error = null;
      });

      Iterable<T>? suggestions = widget.items;
      Object? error;

      try {

        // suggestions = await widget.suggestionsCallback!(widget.controller!.text);
      } catch (e) {
        error = e;
      }

      if (this.mounted) {
        // if it wasn't removed in the meantime
        setState(() {
          double? animationStart = widget.animationStart;
          // allow suggestionsCallback to return null and not throw error here
          if (error != null || suggestions?.isEmpty == true) {
            animationStart = 1.0;
          }
          this._animationController!.forward(from: animationStart);

          this._error = error;
          this._isLoading = false;
          this._suggestions = suggestions;
        });
      }
    }
  }

  @override
  void dispose() {
    _animationController!.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isEmpty =
        this._suggestions?.length == 0 && widget.controller!.text == "";
    if ((this._suggestions == null || isEmpty) && this._isLoading == false)
      return Container();

    Widget child;
    if (this._isLoading!) {
      if (widget.hideOnLoading!) {
        child = Container(height: 0);
      } else {
        child = createLoadingWidget();
      }
    } else if (this._error != null) {
      if (widget.hideOnError!) {
        child = Container(height: 0);
      } else {
        child = createErrorWidget();
      }
    } else if (this._suggestions!.isEmpty) {
      if (widget.hideOnEmpty!) {
        child = Container(height: 0);
      } else {
        child = createNoItemsFoundWidget();
      }
    } else {
      child = createSuggestionsWidget();
    }

    var animationChild = widget.transitionBuilder != null
        ? widget.transitionBuilder!(context, child, this._animationController)
        : SizeTransition(
            axisAlignment: -1.0,
            sizeFactor: CurvedAnimation(
                parent: this._animationController!,
                curve: Curves.fastOutSlowIn),
            child: child,
          );

    BoxConstraints constraints;
    if (widget.decoration!.constraints == null) {
      constraints = BoxConstraints(
        maxHeight: widget.suggestionsBox!.maxHeight,
      );
    } else {
      double maxHeight = min(widget.decoration!.constraints!.maxHeight,
          widget.suggestionsBox!.maxHeight);
      constraints = widget.decoration!.constraints!.copyWith(
        minHeight: min(widget.decoration!.constraints!.minHeight, maxHeight),
        maxHeight: maxHeight,
      );
    }

    var container = Material(
      elevation: widget.decoration!.elevation,
      color: widget.decoration!.color,
      shape: widget.decoration!.shape,
      borderRadius: widget.decoration!.borderRadius,
      shadowColor: widget.decoration!.shadowColor,
      clipBehavior: widget.decoration!.clipBehavior,
      child: ConstrainedBox(
        constraints: constraints,
        child: animationChild,
      ),
    );

    return container;
  }

  Widget createLoadingWidget() {
    Widget child;

    if (widget.keepSuggestionsOnLoading! && this._suggestions != null) {
      if (this._suggestions!.isEmpty) {
        child = createNoItemsFoundWidget();
      } else {
        child = createSuggestionsWidget();
      }
    } else {
      child = widget.loadingBuilder != null
          ? widget.loadingBuilder!(context)
          : Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CircularProgressIndicator(),
              ),
            );
    }

    return child;
  }

  Widget createErrorWidget() {
    return widget.errorBuilder != null
        ? widget.errorBuilder!(context, this._error)
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Error: ${this._error}',
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
          );
  }

  Widget createNoItemsFoundWidget() {
    return widget.noItemsFoundBuilder != null
        ? widget.noItemsFoundBuilder!(context)
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'No Items Found!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).disabledColor, fontSize: 18.0),
            ),
          );
  }

  Widget createSuggestionsWidget() {
    Widget child = ListView(
      padding: EdgeInsets.zero,
      primary: false,
      shrinkWrap: true,
      controller: _scrollController,
      reverse:
          widget.suggestionsBox!.direction == AxisDirection.down ? false : true,
      // reverses the list to start at the bottom
      children: this._suggestions!.map((T suggestion) {
        return InkWell(
          child: widget.itemBuilder!(context, suggestion),
          onTap: () {
            widget.onSuggestionSelected!(suggestion);
          },
        );
      }).toList(),
    );

    if (widget.decoration!.hasScrollbar) {
      child = Scrollbar(
        controller: _scrollController,
        child: child,
      );
    }

    return child;
  }
}

class SuggestionsBoxDecoration {
  final double elevation;
  final Color? color;
  final ShapeBorder? shape;
  final bool hasScrollbar;
  final BorderRadius? borderRadius;
  final Color shadowColor;
  final BoxConstraints? constraints;
  final double offsetX;
  final Clip clipBehavior;

  const SuggestionsBoxDecoration({
    this.elevation: 4.0,
    this.color,
    this.shape,
    this.hasScrollbar: true,
    this.borderRadius,
    this.shadowColor: const Color(0xFF000000),
    this.constraints,
    this.clipBehavior: Clip.none,
    this.offsetX: 0.0,
  });
}

class FilterTextFieldConfiguration {
  final InputDecoration decoration;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool enabled;
  final bool enableSuggestions;
  final TextInputType keyboardType;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final bool autocorrect;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final bool maxLengthEnforced;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Color? cursorColor;
  final Radius? cursorRadius;
  final double cursorWidth;
  final Brightness? keyboardAppearance;
  final VoidCallback? onEditingComplete;
  final GestureTapCallback? onTap;
  final EdgeInsets scrollPadding;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final bool enableInteractiveSelection;

  const FilterTextFieldConfiguration({
    this.decoration: const InputDecoration(),
    this.style,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.obscureText: false,
    this.maxLengthEnforced: true,
    this.maxLength,
    this.maxLines: 1,
    this.minLines,
    this.autocorrect: true,
    this.inputFormatters,
    this.autofocus: false,
    this.keyboardType: TextInputType.text,
    this.enabled: true,
    this.enableSuggestions: true,
    this.textAlign: TextAlign.start,
    this.focusNode,
    this.cursorColor,
    this.cursorRadius,
    this.textInputAction,
    this.textCapitalization: TextCapitalization.none,
    this.cursorWidth: 2.0,
    this.keyboardAppearance,
    this.onEditingComplete,
    this.onTap,
    this.textDirection,
    this.scrollPadding: const EdgeInsets.all(20.0),
    this.enableInteractiveSelection: true,
  });

  copyWith(
      {InputDecoration? decoration,
      TextStyle? style,
      TextEditingController? controller,
      ValueChanged<String>? onChanged,
      ValueChanged<String>? onSubmitted,
      bool? obscureText,
      bool? maxLengthEnforced,
      int? maxLength,
      int? maxLines,
      int? minLines,
      bool? autocorrect,
      List<TextInputFormatter>? inputFormatters,
      bool? autofocus,
      TextInputType? keyboardType,
      bool? enabled,
      bool? enableSuggestions,
      TextAlign? textAlign,
      FocusNode? focusNode,
      Color? cursorColor,
      Radius? cursorRadius,
      double? cursorWidth,
      Brightness? keyboardAppearance,
      VoidCallback? onEditingComplete,
      GestureTapCallback? onTap,
      EdgeInsets? scrollPadding,
      TextCapitalization? textCapitalization,
      TextDirection? textDirection,
      TextInputAction? textInputAction,
      bool? enableInteractiveSelection}) {
    return FilterTextFieldConfiguration(
      decoration: decoration ?? this.decoration,
      style: style ?? this.style,
      controller: controller ?? this.controller,
      onChanged: onChanged ?? this.onChanged,
      onSubmitted: onSubmitted ?? this.onSubmitted,
      obscureText: obscureText ?? this.obscureText,
      maxLengthEnforced: maxLengthEnforced ?? this.maxLengthEnforced,
      maxLength: maxLength ?? this.maxLength,
      maxLines: maxLines ?? this.maxLines,
      minLines: minLines ?? this.minLines,
      autocorrect: autocorrect ?? this.autocorrect,
      inputFormatters: inputFormatters ?? this.inputFormatters,
      autofocus: autofocus ?? this.autofocus,
      keyboardType: keyboardType ?? this.keyboardType,
      enabled: enabled ?? this.enabled,
      enableSuggestions: enableSuggestions ?? this.enableSuggestions,
      textAlign: textAlign ?? this.textAlign,
      focusNode: focusNode ?? this.focusNode,
      cursorColor: cursorColor ?? this.cursorColor,
      cursorRadius: cursorRadius ?? this.cursorRadius,
      cursorWidth: cursorWidth ?? this.cursorWidth,
      keyboardAppearance: keyboardAppearance ?? this.keyboardAppearance,
      onEditingComplete: onEditingComplete ?? this.onEditingComplete,
      onTap: onTap ?? this.onTap,
      scrollPadding: scrollPadding ?? this.scrollPadding,
      textCapitalization: textCapitalization ?? this.textCapitalization,
      textInputAction: textInputAction ?? this.textInputAction,
      textDirection: textDirection ?? this.textDirection,
      enableInteractiveSelection:
          enableInteractiveSelection ?? this.enableInteractiveSelection,
    );
  }
}

class _SuggestionsBox {
  static const int waitMetricsTimeoutMillis = 1000;
  static const double minOverlaySpace = 64.0;

  final BuildContext context;
  final AxisDirection desiredDirection;
  final bool autoFlipDirection;

  OverlayEntry? _overlayEntry;
  AxisDirection direction;

  bool isOpened = false;
  bool widgetMounted = true;
  double maxHeight = 300.0;
  double textBoxWidth = 100.0;
  double textBoxHeight = 100.0;
  late double directionUpOffset;

  _SuggestionsBox(this.context, this.direction, this.autoFlipDirection)
      : desiredDirection = direction;

  void open() {
    if (this.isOpened) return;
    assert(this._overlayEntry != null);
    Overlay.of(context)!.insert(this._overlayEntry!);
    this.isOpened = true;
  }

  void close() {
    if (!this.isOpened) return;
    assert(this._overlayEntry != null);
    this._overlayEntry!.remove();
    this.isOpened = false;
  }

  void toggle() {
    if (this.isOpened) {
      this.close();
    } else {
      this.open();
    }
  }

  MediaQuery? _findRootMediaQuery() {
    MediaQuery? rootMediaQuery;
    context.visitAncestorElements((element) {
      if (element.widget is MediaQuery) {
        rootMediaQuery = element.widget as MediaQuery;
      }
      return true;
    });

    return rootMediaQuery;
  }

  Future<bool> _waitChangeMetrics() async {
    if (widgetMounted) {
      // initial viewInsets which are before the keyboard is toggled
      EdgeInsets initial = MediaQuery.of(context).viewInsets;
      // initial MediaQuery for orientation change
      MediaQuery? initialRootMediaQuery = _findRootMediaQuery();

      int timer = 0;
      // viewInsets or MediaQuery have changed once keyboard has toggled or orientation has changed
      while (widgetMounted && timer < waitMetricsTimeoutMillis) {
        await Future.delayed(const Duration(milliseconds: 170));
        timer += 170;

        if (widgetMounted &&
            (MediaQuery.of(context).viewInsets != initial ||
                _findRootMediaQuery() != initialRootMediaQuery)) {
          return true;
        }
      }
    }

    return false;
  }

  void resize() {
    // check to see if widget is still mounted
    // user may have closed the widget with the keyboard still open
    if (widgetMounted) {
      _adjustMaxHeightAndOrientation();
      _overlayEntry!.markNeedsBuild();
    }
  }

  // See if there's enough room in the desired direction for the overlay to display
  // correctly. If not, try the opposite direction if things look more roomy there
  void _adjustMaxHeightAndOrientation() {
    FilterTextField widget = context.widget as FilterTextField;

    RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box == null || box.hasSize == false) {
      return;
    }

    textBoxWidth = box.size.width;
    textBoxHeight = box.size.height;

    // top of text box
    double textBoxAbsY = box.localToGlobal(Offset.zero).dy;

    // height of window
    double windowHeight = MediaQuery.of(context).size.height;

    // we need to find the root MediaQuery for the unsafe area height
    // we cannot use BuildContext.ancestorWidgetOfExactType because
    // widgets like SafeArea creates a new MediaQuery with the padding removed
    MediaQuery rootMediaQuery = _findRootMediaQuery()!;

    // height of keyboard
    double keyboardHeight = rootMediaQuery.data.viewInsets.bottom;

    double maxHDesired = _calculateMaxHeight(desiredDirection, box, widget,
        windowHeight, rootMediaQuery, keyboardHeight, textBoxAbsY);

    // if there's enough room in the desired direction, update the direction and the max height
    if (maxHDesired >= minOverlaySpace || !autoFlipDirection) {
      direction = desiredDirection;
      maxHeight = maxHDesired;
    } else {
      // There's not enough room in the desired direction so see how much room is in the opposite direction
      AxisDirection flipped = flipAxisDirection(desiredDirection);
      double maxHFlipped = _calculateMaxHeight(flipped, box, widget,
          windowHeight, rootMediaQuery, keyboardHeight, textBoxAbsY);

      // if there's more room in this opposite direction, update the direction and maxHeight
      if (maxHFlipped > maxHDesired) {
        direction = flipped;
        maxHeight = maxHFlipped;
      }
    }

    if (maxHeight < 0) maxHeight = 0;
  }

  double _calculateMaxHeight(
      AxisDirection direction,
      RenderBox box,
      FilterTextField widget,
      double windowHeight,
      MediaQuery rootMediaQuery,
      double keyboardHeight,
      double textBoxAbsY) {
    return direction == AxisDirection.down
        ? _calculateMaxHeightDown(box, widget, windowHeight, rootMediaQuery,
            keyboardHeight, textBoxAbsY)
        : _calculateMaxHeightUp(box, widget, windowHeight, rootMediaQuery,
            keyboardHeight, textBoxAbsY);
  }

  double _calculateMaxHeightDown(
      RenderBox box,
      FilterTextField widget,
      double windowHeight,
      MediaQuery rootMediaQuery,
      double keyboardHeight,
      double textBoxAbsY) {
    // unsafe area, ie: iPhone X 'home button'
    // keyboardHeight includes unsafeAreaHeight, if keyboard is showing, set to 0
    double unsafeAreaHeight =
        keyboardHeight == 0 ? rootMediaQuery.data.padding.bottom : 0;

    return windowHeight -
        keyboardHeight -
        unsafeAreaHeight -
        textBoxHeight -
        textBoxAbsY -
        2 * widget.suggestionsBoxVerticalOffset;
  }

  double _calculateMaxHeightUp(
      RenderBox box,
      FilterTextField widget,
      double windowHeight,
      MediaQuery rootMediaQuery,
      double keyboardHeight,
      double textBoxAbsY) {
    // recalculate keyboard absolute y value
    double keyboardAbsY = windowHeight - keyboardHeight;

    directionUpOffset = textBoxAbsY > keyboardAbsY
        ? keyboardAbsY - textBoxAbsY - widget.suggestionsBoxVerticalOffset
        : -widget.suggestionsBoxVerticalOffset;

    // unsafe area, ie: iPhone X notch
    double unsafeAreaHeight = rootMediaQuery.data.padding.top;

    return textBoxAbsY > keyboardAbsY
        ? keyboardAbsY -
            unsafeAreaHeight -
            2 * widget.suggestionsBoxVerticalOffset
        : textBoxAbsY -
            unsafeAreaHeight -
            2 * widget.suggestionsBoxVerticalOffset;
  }

  Future<void> onChangeMetrics() async {
    if (await _waitChangeMetrics()) {
      resize();
    }
  }
}

class SuggestionsBoxController {
  _SuggestionsBox? _suggestionsBox;
  FocusNode? _effectiveFocusNode;

  void open() {
    _effectiveFocusNode!.requestFocus();
  }

  bool isOpened() {
    return _suggestionsBox!.isOpened;
  }

  void close() {
    _effectiveFocusNode!.unfocus();
  }

  void toggle() {
    if (_suggestionsBox!.isOpened) {
      close();
    } else {
      open();
    }
  }

  void resize() {
    _suggestionsBox!.resize();
  }
}
