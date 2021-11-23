part of 'errand_page.dart';

class _StoreNameInput extends StatelessWidget {
  _StoreNameInput(this.controller);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: null,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'Store name',
        labelStyle: Theme.of(context)
            .textTheme
            .bodyText2
            ?.copyWith(fontWeight: FontWeight.w700),
        focusedBorder: AppTheme.textOutlineFocusedBorder(context),
        enabledBorder: AppTheme.textOutlineEnabledBorder(context),
        errorBorder: AppTheme.textOutlineErrorBorder(context),
        focusedErrorBorder: AppTheme.textOutlineFocusedBorder(context),
      ),
      onChanged: (val) {
        final action = ErrandAction.OnStoreNameChanged;
        final event = ErrandEvent(action, val);
        context.read<ErrandBloc>().add(event);
      },
    );
  }
}

class _StoreAddressInput extends StatelessWidget {
  _StoreAddressInput(this.controller);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      debounceDuration: Duration(milliseconds: 1000),
      minCharsForSuggestions: 2,
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
        keyboardType: TextInputType.streetAddress,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: 'Store address',
          labelStyle: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(fontWeight: FontWeight.w700),
          hintText: 'Search and select an address',
          hintStyle: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(color: Colors.grey, fontWeight: FontWeight.w700),
          focusedBorder: AppTheme.textOutlineFocusedBorder(context),
          enabledBorder: AppTheme.textOutlineEnabledBorder(context),
          errorBorder: AppTheme.textOutlineErrorBorder(context),
          focusedErrorBorder: AppTheme.textOutlineFocusedBorder(context),
        ),
      ),
      suggestionsCallback: (pattern) async {
        return await context.read<ErrandBloc>().searchPlaces(pattern);
      },
      itemBuilder: (_, Prediction prediction) => ListTile(
        title: Text(
          prediction.description,
          style: Theme.of(context).textTheme.caption,
        ),
      ),
      errorBuilder: (_, e) => ListTile(
        title: Text(
          'Error searching location',
          style: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(color: Theme.of(context).errorColor),
        ),
      ),
      loadingBuilder: (_) => ListTile(
        trailing: SizedBox(
          height: 16,
          width: 16,
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
      hideOnEmpty: true,
      hideSuggestionsOnKeyboardHide: true,
      onSuggestionSelected: (Prediction data) {
        TextUtil.setText(controller, data.description);
        final action = ErrandAction.OnSetStoreAddressDetail;
        final event = ErrandEvent(action, data);
        context.read<ErrandBloc>().add(event);
      },
    );
  }
}

class _DeliveryAddressInput extends StatelessWidget {
  _DeliveryAddressInput(this.controller);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      debounceDuration: Duration(milliseconds: 1000),
      minCharsForSuggestions: 2,
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
        keyboardType: TextInputType.streetAddress,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: 'Delivery address',
          labelStyle: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(fontWeight: FontWeight.w700),
          hintText: 'Search and select an address',
          hintStyle: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(color: Colors.grey, fontWeight: FontWeight.w700),
          focusedBorder: AppTheme.textOutlineFocusedBorder(context),
          enabledBorder: AppTheme.textOutlineEnabledBorder(context),
          errorBorder: AppTheme.textOutlineErrorBorder(context),
          focusedErrorBorder: AppTheme.textOutlineFocusedBorder(context),
        ),
      ),
      suggestionsCallback: (pattern) async {
        return await context.read<ErrandBloc>().searchPlaces(pattern);
      },
      itemBuilder: (_, Prediction prediction) => ListTile(
        title: Text(
          prediction.description,
          style: Theme.of(context).textTheme.caption,
        ),
      ),
      errorBuilder: (_, e) => ListTile(
        title: Text(
          'Error searching location',
          style: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(color: Theme.of(context).errorColor),
        ),
      ),
      loadingBuilder: (_) => ListTile(
        trailing: SizedBox(
          height: 16,
          width: 16,
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
      hideOnEmpty: true,
      hideSuggestionsOnKeyboardHide: true,
      onSuggestionSelected: (Prediction data) {
        TextUtil.setText(controller, data.description);
        final action = ErrandAction.OnSetDeliveryAddressDetail;
        final event = ErrandEvent(action, data);
        context.read<ErrandBloc>().add(event);
      },
    );
  }
}

class _DistanceCalculationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ErrandBloc, ErrandState>(
      builder: (_, state) => Visibility(
        visible: state.estimatedDistance.isNotEmpty,
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24),
              Text(
                'Distance: ${state.estimatedDistance.text}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              Text(
                'Estimated Time: ${state.estimatedDuration.text}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ShoppingCartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.blue[900],
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              'Shopping cart',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
          _CartItemsView(),
          BlocSelector<ErrandBloc, ErrandState, double>(
            selector: (s) => s.totalCartPrice,
            builder: (context, total) {
              return Visibility(
                visible: total != 0,
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Text(
                    'Total Price: ${convertToNairaAndKobo(total)}',
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontFamily: 'Roboto', fontWeight: FontWeight.w700),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CartItemsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<ErrandBloc, ErrandState, List<CartItem>>(
      selector: (s) => s.cartItems,
      builder: (context, items) {
        if (items.isNotEmpty) {
          return Flexible(
            fit: FlexFit.loose,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_, i) => ListTile(
                dense: true,
                leading: Text(
                  items[i].quantity.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2,
                ),
                title: Text(
                  items[i].name,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1,
                ),
                trailing: InkWell(
                  child: Icon(
                    MdiIcons.close,
                    size: 20.0,
                  ),
                  onTap: () {
                    final event = ErrandEvent(ErrandAction.OnItemRemoved, i);
                    context.read<ErrandBloc>().add(event);
                  },
                ),
              ),
            ),
          );
        }
        return Center(
          child: Text('No item added'),
        );
      },
    );
  }
}

class _AddOrderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          textStyle: Theme.of(context)
              .textTheme
              .button
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        onPressed: () {
          CartDialog()..show(context);
        },
        icon: Icon(
          MdiIcons.plus,
          size: 16.0,
        ),
        label: Text('Add'),
      ),
    );
  }
}

class _NextToProcessButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ErrandBloc, ErrandState>(
      builder: (_, s) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(16),
            textStyle: Theme.of(context).textTheme.button,
          ),
          onPressed: s.buttonActive ? () => navigate(context) : null,
          child: Builder(
            builder: (_) {
              if (s.loading && !s.calculating) {
                return SizedBox(
                    child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation(Colors.blue.shade500),
                ));
              }
              return Icon(MdiIcons.chevronRight);
            },
          ),
        ),
      ),
    );
  }

  void navigate(BuildContext context) async {
    final res = await Navigator.of(context).push(ProcessDeliveryPage.route());
    if (res != null && res is bool && res) {
      ErrandSummaryDialog()..show(context);
    }
  }
}
