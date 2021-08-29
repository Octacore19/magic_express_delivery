part of 'errand_page.dart';

class _StoreNameInput extends StatelessWidget {
  _StoreNameInput(this.controller);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: null,
      minLines: 2,
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
    return BlocBuilder<ErrandBloc, ErrandState>(
      builder: (context, state) {
        return TypeAheadField(
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
          _AddItemDialog()..show(context);
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

class _ItemNameInput extends StatelessWidget {
  const _ItemNameInput(this.controller);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.next,
      cursorColor: Colors.grey,
      onChanged: (s) {
        final event = ErrandEvent(ErrandAction.OnItemNameChanged, s);
        context.read<ErrandBloc>().add(event);
      },
      decoration: InputDecoration(
        labelText: 'Item name',
        isDense: true,
        labelStyle: AppTheme.textFieldHeaderStyle(context),
        focusedBorder: AppTheme.textOutlineFocusedBorder(context),
        enabledBorder: AppTheme.textOutlineEnabledBorder(context),
        errorBorder: AppTheme.textOutlineErrorBorder(context),
        focusedErrorBorder: AppTheme.textOutlineFocusedBorder(context),
      ),
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  const _DescriptionInput(this.controller);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      cursorColor: Colors.grey,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.next,
      maxLines: null,
      minLines: 2,
      onChanged: (s) {
        final event = ErrandEvent(ErrandAction.OnItemDescriptionChanged, s);
        context.read<ErrandBloc>().add(event);
      },
      decoration: InputDecoration(
        labelText: 'Description',
        isDense: true,
        labelStyle: AppTheme.textFieldHeaderStyle(context),
        border: AppTheme.textOutlineEnabledBorder(context),
        focusedBorder: AppTheme.textOutlineFocusedBorder(context),
        enabledBorder: AppTheme.textOutlineEnabledBorder(context),
        errorBorder: AppTheme.textOutlineErrorBorder(context),
        focusedErrorBorder: AppTheme.textOutlineFocusedBorder(context),
      ),
    );
  }
}

class _QuantityInput extends StatelessWidget {
  const _QuantityInput(this.controller);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        onChanged: (s) {
          final event = ErrandEvent(ErrandAction.OnItemQuantityChanged, s);
          context.read<ErrandBloc>().add(event);
        },
        decoration: InputDecoration(
          labelText: 'Quantity',
          isDense: true,
          labelStyle: AppTheme.textFieldHeaderStyle(context),
        ),
      ),
    );
  }
}

class _UnitPriceInput extends StatelessWidget {
  const _UnitPriceInput(this.controller);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(),
        onChanged: (s) {
          final event = ErrandEvent(ErrandAction.OnItemPriceChanged, s);
          context.read<ErrandBloc>().add(event);
        },
        decoration: InputDecoration(
          labelText: 'Unit Price',
          isDense: true,
          labelStyle: AppTheme.textFieldHeaderStyle(context),
        ),
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
          onPressed: () =>
              Navigator.of(context).push(ProcessDeliveryPage.route()),
          /*onPressed: enabled
              ? () {
                  Navigator.of(context).push(ProcessDeliveryPage.route());
                }
              : null,*/
          icon: Icon(MdiIcons.chevronRight),
          label: Text(''),
        ),
      ),
    );
  }
}

class _AddItemDialog extends StatefulWidget {
  void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<ErrandBloc>(context),
        child: _AddItemDialog(),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<_AddItemDialog> {
  final _itemNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context.read<ErrandBloc>().state;
    TextUtil.setText(_itemNameController, state.itemName);
    TextUtil.setText(_descriptionController, state.description);
    TextUtil.setText(_quantityController, state.quantity);
    TextUtil.setText(_priceController, state.unitPrice);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(16),
      actions: [
        TextButton(
          child: Text('Save'),
          onPressed: () {
            FocusScope.of(context).unfocus();
            final event = ErrandEvent(ErrandAction.OnItemAdded);
            context.read<ErrandBloc>().add(event);
          },
        ),
        TextButton(
          child: Text('Finish'),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
      ],
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add an item', style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 24),
            _ItemNameInput(_itemNameController),
            const SizedBox(height: 24),
            _DescriptionInput(_descriptionController),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _QuantityInput(_quantityController),
                const SizedBox(width: 72),
                _UnitPriceInput(_priceController)
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
