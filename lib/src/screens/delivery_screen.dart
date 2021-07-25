import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:magic_express_delivery/src/commons/routes.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DeliveryScreen extends StatefulWidget {
  final int _taskType;
  final int _vehicleType;
  final int _deliveryType;

  DeliveryScreen(this._taskType, this._vehicleType, this._deliveryType);

  @override
  State<StatefulWidget> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  List _items = [];

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityCOntroller = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _quantityCOntroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
          TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Pickup address',
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
                labelText: 'Drop-off address',
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
                'Delivery cart',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.apply(color: Colors.white),
              ),
            ),
            _itemsListContent,
          ],
        ),
      ),
    );
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
          TextField(
            controller: _quantityCOntroller,
            decoration: InputDecoration(
              isDense: true,
              labelText: 'Quantity',
              labelStyle: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          TextButton.icon(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.button,
            ),
            onPressed: () {
              final name = _titleController.text.trim();
              final description = _descriptionController.text.trim();
              final quantity = _quantityCOntroller.text.trim();
              if (name.isNotEmpty && quantity.isNotEmpty) {
                setState(() {
                  _items.add({
                    'name': name,
                    'description': description,
                    'quantity': quantity,
                  });
                  _titleController.clear();
                  _descriptionController.clear();
                  _quantityCOntroller.clear();
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
            Routes.PROCESS_DELIVERY,
            arguments: [widget._taskType, widget._vehicleType, widget._deliveryType],
          );
        },
        icon: Icon(MdiIcons.chevronRight),
        label: Text(''),
      ),
    );
  }
}
