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
        labelStyle: Theme.of(context).textTheme.bodyText2,
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
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
        keyboardType: TextInputType.streetAddress,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: 'Store address',
          labelStyle: Theme.of(context).textTheme.bodyText2,
          focusedBorder: AppTheme.textOutlineFocusedBorder(context),
          enabledBorder: AppTheme.textOutlineEnabledBorder(context),
          errorBorder: AppTheme.textOutlineErrorBorder(context),
          focusedErrorBorder: AppTheme.textOutlineFocusedBorder(context),
        ),
      ),
      suggestionsCallback: (pattern) async {
        return context.read<ErrandBloc>().searchPlaces(pattern);
      },
      itemBuilder: (_, Prediction prediction) => ListTile(
        title: Text(prediction.description),
      ),
      loadingBuilder: (_) => ListTile(
        trailing: CircularProgressIndicator.adaptive(),
      ),
      hideOnError: true,
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
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
        keyboardType: TextInputType.streetAddress,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: 'Delivery address',
          labelStyle: Theme.of(context).textTheme.bodyText2,
          focusedBorder: AppTheme.textOutlineFocusedBorder(context),
          enabledBorder: AppTheme.textOutlineEnabledBorder(context),
          errorBorder: AppTheme.textOutlineErrorBorder(context),
          focusedErrorBorder: AppTheme.textOutlineFocusedBorder(context),
        ),
      ),
      suggestionsCallback: (pattern) async {
        return context.read<ErrandBloc>().searchPlaces(pattern);
      },
      itemBuilder: (_, Prediction prediction) => ListTile(
        title: Text(prediction.description),
      ),
      loadingBuilder: (_) => ListTile(
        trailing: CircularProgressIndicator.adaptive(),
      ),
      hideOnError: true,
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
                  ?.apply(color: Colors.white),
            ),
          ),
          _CartItemsView(),
          BlocSelector<ErrandBloc, ErrandState, double>(
            selector: (s) => s.totalPrice,
            builder: (context, total) {
              return Visibility(
                visible: total != 0,
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Text(
                    'Total Price: ${convertToNairaAndKobo(total)}',
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.apply(fontFamily: 'Roboto'),
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
              itemBuilder: (_, i) => ListTile(
                dense: true,
                leading: Text(items[i].quantity.toString()),
                title: Text(items[i].name),
                trailing: InkWell(
                  child: Icon(
                    MdiIcons.close,
                    size: 16.0,
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
          textStyle: Theme.of(context).textTheme.button,
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
    return BlocSelector<ErrandBloc, ErrandState, bool>(
      selector: (s) => s.buttonActive,
      builder: (_, enabled) => SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(16),
            textStyle: Theme.of(context).textTheme.button,
          ),
          onPressed: enabled
              ? () {
                  Navigator.of(context).push(ProcessDeliveryPage.route());
                }
              : null,
          icon: Icon(MdiIcons.chevronRight),
          label: Text(''),
        ),
      ),
    );
  }
}
