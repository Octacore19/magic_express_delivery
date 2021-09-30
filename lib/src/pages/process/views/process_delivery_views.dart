part of 'process_delivery_page.dart';

class _NameInput extends StatelessWidget {
  _NameInput({
    required this.header,
    required this.controller,
    required this.visible,
  });

  final String header;
  final TextEditingController controller;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: TextField(
        controller: controller,
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: header,
          labelStyle: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(fontWeight: FontWeight.w700),
          border: AppTheme.textOutlineEnabledBorder(context),
          enabledBorder: AppTheme.textOutlineEnabledBorder(context),
          focusedBorder: AppTheme.textOutlineFocusedBorder(context),
          errorBorder: AppTheme.textOutlineErrorBorder(context),
          focusedErrorBorder: AppTheme.textOutlineErrorFocusedBorder(context),
        ),
      ),
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  _PhoneNumberInput({
    required this.header,
    required this.controller,
    required this.visible,
  });

  final String header;
  final TextEditingController controller;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: header,
          labelStyle: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(fontWeight: FontWeight.w700),
          border: AppTheme.textOutlineEnabledBorder(context),
          enabledBorder: AppTheme.textOutlineEnabledBorder(context),
          focusedBorder: AppTheme.textOutlineFocusedBorder(context),
          errorBorder: AppTheme.textOutlineErrorBorder(context),
          focusedErrorBorder: AppTheme.textOutlineErrorFocusedBorder(context),
        ),
      ),
    );
  }
}

class _DeliveryNoteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        textStyle: Theme.of(context)
            .textTheme
            .button
            ?.copyWith(fontWeight: FontWeight.w700),
      ),
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => BlocProvider.value(
            value: BlocProvider.of<ProcessDeliveryCubit>(context),
            child: AlertDialog(
              title: Text('Delivery Note'),
              actions: [
                TextButton(
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                  child: Text('OK'),
                )
              ],
              content: TextField(
                maxLines: null,
                minLines: 3,
                onChanged: (val) {
                  context
                      .read<ProcessDeliveryCubit>()
                      .onDeliveryNoteChanged(val);
                },
                decoration: InputDecoration(
                  hintText: 'Start typing...',
                  border: AppTheme.textOutlineEnabledBorder(context),
                  enabledBorder: AppTheme.textOutlineEnabledBorder(context),
                  focusedBorder: AppTheme.textOutlineFocusedBorder(context),
                  errorBorder: AppTheme.textOutlineErrorBorder(context),
                  focusedErrorBorder:
                      AppTheme.textOutlineErrorFocusedBorder(context),
                ),
              ),
            ),
          ),
        );
      },
      icon: Icon(
        MdiIcons.plus,
        size: 20.0,
      ),
      label: Text('Add a delivery note'),
    );
  }
}

class _PaymentOptionsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProcessDeliveryCubit, ProcessDeliveryState, List<bool>>(
      selector: (s) => s.paymentSelection,
      builder: (_, selection) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Select payment method:',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ToggleButtons(
              isSelected: selection,
              children: paymentSelectionWidgets(context),
              onPressed: (i) {
                context
                    .read<ProcessDeliveryCubit>()
                    .onSelectionOptionsChanged(i);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> paymentSelectionWidgets(BuildContext context) {
    final state = context.read<ProcessDeliveryCubit>().state;
    List<Widget> content = [];
    if (state.errand) {
      content.addAll([
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text.rich(
            TextSpan(
              text: 'Cash  ',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontWeight: FontWeight.w700),
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    MdiIcons.cash,
                    size: 24.0,
                    color: Colors.blue[900],
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text.rich(
            TextSpan(
              text: 'Card   ',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontWeight: FontWeight.w700),
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    MdiIcons.creditCard,
                    size: 24.0,
                    color: Colors.blue[900],
                  ),
                )
              ],
            ),
          ),
        )
      ]);
    } else {
      content.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text.rich(
            TextSpan(
              text: 'Cash   ',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontWeight: FontWeight.w700),
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    MdiIcons.cash,
                    size: 24.0,
                    color: Colors.blue[900],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
    return content;
  }
}

class _NextToSummaryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProcessDeliveryCubit, ProcessDeliveryState, bool>(
      selector: (s) => s.buttonActive,
      builder: (_, enabled) => SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(16),
            textStyle: Theme.of(context).textTheme.button,
          ),
          onPressed: enabled ? () => Navigator.of(context).pop(true) : null,
          icon: Icon(MdiIcons.chevronRight),
          label: Text(''),
        ),
      ),
    );
  }
}
