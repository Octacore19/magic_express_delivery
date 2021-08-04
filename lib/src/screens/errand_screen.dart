import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ErrandScreen extends StatefulWidget {
  final int _taskType;
  final int _vehicleType;
  final int _deliveryType;

  ErrandScreen(this._taskType, this._vehicleType, this._deliveryType);

  @override
  State<StatefulWidget> createState() => _ErrandScreenState();
}

class _ErrandScreenState extends State<ErrandScreen> {
  List _items = [];

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitPriceController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    _unitPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _deliveryOption,
            _itemsList,
            _itemsOption,
            _nextButton,
          ],
        ),
      ),
    );
  }

  Widget get _deliveryOption {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              isDense: true,
              labelText: 'Store name',
              labelStyle: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          TypeAheadField(
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
          ),
          SizedBox(
            height: 8.0,
          ),
          TypeAheadField(
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
          )
        ],
      ),
    );
  }

  Widget get _itemsList {
    return Container(
      margin: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Card(
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
            _itemsListContent,
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: LayoutBuilder(
                builder: (_, __) {
                  if (_items.isNotEmpty) {
                    int price = 0;
                    _items.forEach((element) {
                      price += int.parse(element['totalPrice']);
                    });
                    final symbol = getCurrency();
                    return Text(
                      'Total Price: $symbol ${price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.caption,
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getCurrency() {
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
    return format.currencySymbol;
  }

  Widget get _itemsListContent {
    if (_items.isNotEmpty) {
      return Flexible(
        fit: FlexFit.loose,
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (_, i) => ListTile(
            dense: true,
            leading: Text(_items[i]['quantity'].toString()),
            title: Text(_items[i]['name'].toString()),
            trailing: InkWell(
              child: Icon(
                MdiIcons.close,
                size: 16.0,
              ),
              onTap: () {
                setState(() {
                  _items.removeAt(i);
                });
              },
            ),
          ),
          itemCount: _items.length,
        ),
      );
    }
    return Center(
      child: Text('No item added'),
    );
  }

  Widget get _itemsOption {
    return Container(
      margin: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              isDense: true,
              labelText: 'Item name',
              labelStyle: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(
              isDense: true,
              labelText: 'Description',
              labelStyle: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: TextField(
                  controller: _quantityController,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Quantity',
                    labelStyle: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
              SizedBox(width: 96.0),
              Flexible(
                child: TextField(
                  controller: _unitPriceController,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Unit Price',
                    labelStyle: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
            ],
          ),
          TextButton.icon(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.button,
            ),
            onPressed: () {
              final name = _titleController.text.trim();
              final description = _descriptionController.text.trim();
              final quantity = _quantityController.text.trim();
              final unitPrice = _unitPriceController.text.trim();
              final totalPrice =
                  (int.parse(quantity) * int.parse(unitPrice)).toString();
              if (name.isNotEmpty &&
                  quantity.isNotEmpty &&
                  unitPrice.isNotEmpty) {
                setState(() {
                  _items.add({
                    'name': name,
                    'description': description,
                    'quantity': quantity,
                    'unitPrice': unitPrice,
                    'totalPrice': totalPrice,
                  });
                  _titleController.clear();
                  _descriptionController.clear();
                  _quantityController.clear();
                  _unitPriceController.clear();
                });
              }
            },
            icon: Icon(
              MdiIcons.plus,
              size: 16.0,
            ),
            label: Text('Add'),
          )
        ],
      ),
    );
  }

  Widget get _nextButton {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 56.0, right: 16.0, left: 16.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(12.0),
          textStyle: Theme.of(context).textTheme.button,
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes.PROCESS_DELIVERY,
            arguments: [
              widget._taskType,
              widget._vehicleType,
              widget._deliveryType
            ],
          );
        },
        icon: Icon(MdiIcons.chevronRight),
        label: Text(''),
      ),
    );
  }
}
