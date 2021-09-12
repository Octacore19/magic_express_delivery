part of 'delivery_page.dart';

class _PickUpAddressInput extends StatelessWidget {
  _PickUpAddressInput(this.controller);

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
          labelText: 'Pickup address',
          labelStyle: Theme.of(context).textTheme.bodyText2,
          focusedBorder: AppTheme.textOutlineFocusedBorder(context),
          enabledBorder: AppTheme.textOutlineEnabledBorder(context),
          errorBorder: AppTheme.textOutlineErrorBorder(context),
          focusedErrorBorder: AppTheme.textOutlineFocusedBorder(context),
        ),
      ),
      suggestionsCallback: (pattern) async {
        return await context.read<DeliveryBloc>().searchPlaces(pattern);
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
        final action = DeliveryAction.OnSetPickupAddressDetail;
        final event = DeliveryEvent(action, data);
        context.read<DeliveryBloc>().add(event);
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
        return await context.read<DeliveryBloc>().searchPlaces(pattern);
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
        final action = DeliveryAction.OnSetDeliveryAddressDetail;
        final event = DeliveryEvent(action, data);
        context.read<DeliveryBloc>().add(event);
      },
    );
  }
}

class _DistanceCalculationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<DeliveryBloc, DeliveryState, double>(
      selector: (s) => s.distance,
      builder: (_, distance) => Visibility(
        visible: distance != 0,
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Distance: ${distance.toStringAsFixed(2)} km',
            style: Theme.of(context).textTheme.caption,
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
              'Delivery items',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.apply(color: Colors.white),
            ),
          ),
          _CartItemsView(),
          BlocSelector<DeliveryBloc, DeliveryState, double>(
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
    return BlocSelector<DeliveryBloc, DeliveryState, List<CartItem>>(
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
                    final action = DeliveryAction.OnItemRemoved;
                    final event = DeliveryEvent(action, i);
                    context.read<DeliveryBloc>().add(event);
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
    return BlocBuilder<DeliveryBloc, DeliveryState>(
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
              if (s.loading) {
                return SizedBox(child: CircularProgressIndicator.adaptive());
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
      DeliverySummaryDialog()..show(context);
    }
  }
}
