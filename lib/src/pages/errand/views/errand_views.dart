part of 'errand_page.dart';

class _StoreNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Store name',
        labelStyle: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}

class _StoreAddressInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        keyboardType: TextInputType.streetAddress,
        decoration: InputDecoration(
          labelText: 'Store address',
          labelStyle: Theme.of(context).textTheme.bodyText2,
        ),
      ),
      suggestionsCallback: (pattern) async {
        return [];
      },
      itemBuilder: (_, __) => ListTile(),
      onSuggestionSelected: (data) {},
    );
  }
}

class _DeliveryAddressInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        keyboardType: TextInputType.streetAddress,
        decoration: InputDecoration(
          labelText: 'Delivery address',
          labelStyle: Theme.of(context).textTheme.bodyText2,
        ),
      ),
      suggestionsCallback: (pattern) async {
        return [];
      },
      itemBuilder: (_, __) => ListTile(),
      onSuggestionSelected: (data) {},
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
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                    final event = ErrandEvent(ErrandEvents.OnItemRemoved, i);
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
          /*FocusScope.of(context).unfocus();
          final event = ErrandEvent(ErrandEvents.OnItemAdded);
          context.read<ErrandBloc>().add(event);*/
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
      onChanged: (s) {
        final event = ErrandEvent(ErrandEvents.OnItemNameChanged, s);
        context.read<ErrandBloc>().add(event);
      },
      decoration: InputDecoration(
        labelText: 'Item name',
        labelStyle: Theme.of(context).textTheme.bodyText2,
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
      onChanged: (s) {
        final event = ErrandEvent(ErrandEvents.OnItemDescriptionChanged, s);
        context.read<ErrandBloc>().add(event);
      },
      decoration: InputDecoration(
        labelText: 'Description',
        labelStyle: Theme.of(context).textTheme.bodyText2,
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
        onChanged: (s) {
          final event = ErrandEvent(ErrandEvents.OnItemQuantityChanged, s);
          context.read<ErrandBloc>().add(event);
        },
        decoration: InputDecoration(
          labelText: 'Quantity',
          labelStyle: Theme.of(context).textTheme.bodyText2,
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
        onChanged: (s) {
          final event = ErrandEvent(ErrandEvents.OnItemPriceChanged, s);
          context.read<ErrandBloc>().add(event);
        },
        decoration: InputDecoration(
          labelText: 'Unit Price',
          labelStyle: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }
}

class _NextToProcessButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(16),
          textStyle: Theme.of(context).textTheme.button,
        ),
        onPressed: () {
          /*Navigator.pushNamed(
            context,
            AppRoutes.PROCESS_DELIVERY,
            arguments: [
              widget._taskType,
              widget._vehicleType,
              widget._deliveryType
            ],
          );*/
        },
        icon: Icon(MdiIcons.chevronRight),
        label: Text(''),
      ),
    );
  }
}

class _AddItemDialog extends StatefulWidget {
  void show(BuildContext context) {
    showDialog(context: context, builder: (_) => _AddItemDialog());
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
      content: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          children: [
            _ItemNameInput(_itemNameController),
            const SizedBox(height: 8.0),
            _DescriptionInput(_descriptionController),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _QuantityInput(_quantityController),
                const SizedBox(width: 96.0),
                _UnitPriceInput(_priceController)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
