import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:magic_express_delivery/src/errand/errand.dart';
import 'package:magic_express_delivery/src/utils/currency_converter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class StoreNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        isDense: true,
        labelText: 'Store name',
        labelStyle: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}

class StoreAddressInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        keyboardType: TextInputType.streetAddress,
        decoration: InputDecoration(
          isDense: true,
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

class DeliveryAddressInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        keyboardType: TextInputType.streetAddress,
        decoration: InputDecoration(
          isDense: true,
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

class ShoppingCartView extends StatelessWidget {
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
          CartItemsView(),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: BlocSelector<ErrandBloc, ErrandState, double>(
              selector: (s) => s.totalPrice,
              builder: (context, total) {
                if (total != 0) {
                  return Text(
                    'Total Price: ${convertToNairaAndKobo(total)}',
                    style: Theme.of(context).textTheme.caption?.apply(
                      fontFamily: 'Roboto'
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CartItemsView extends StatelessWidget {
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

class ItemNameInput extends StatelessWidget {
  const ItemNameInput(this.controller);

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
        isDense: true,
        labelText: 'Item name',
        labelStyle: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}

class DescriptionInput extends StatelessWidget {
  const DescriptionInput(this.controller);

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
        isDense: true,
        labelText: 'Description',
        labelStyle: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}

class QuantityInput extends StatelessWidget {
  const QuantityInput(this.controller);

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
          isDense: true,
          labelText: 'Quantity',
          labelStyle: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }
}

class UnitPriceInput extends StatelessWidget {
  const UnitPriceInput(this.controller);

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
          isDense: true,
          labelText: 'Unit Price',
          labelStyle: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }
}

class AddOrderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        textStyle: Theme.of(context).textTheme.button,
      ),
      onPressed: () {
        FocusScope.of(context).unfocus();
        final event = ErrandEvent(ErrandEvents.OnItemAdded);
        context.read<ErrandBloc>().add(event);
      },
      icon: Icon(
        MdiIcons.plus,
        size: 16.0,
      ),
      label: Text('Add'),
    );
  }
}

class NextToProcessButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(12.0),
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
