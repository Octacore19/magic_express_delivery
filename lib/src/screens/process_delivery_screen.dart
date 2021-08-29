import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProcessDeliveryScreen extends StatefulWidget {
  final int _taskType;
  final int _vehicleType;
  final int _deliveryType;

  ProcessDeliveryScreen(this._taskType, this._vehicleType, this._deliveryType);

  @override
  State<StatefulWidget> createState() => _ProcessDeliveryScreenState();
}

class _ProcessDeliveryScreenState extends State<ProcessDeliveryScreen> {
  late List<bool> _paymentSelection;
  late int _paymentIndex;

  @override
  void initState() {
    if (widget._taskType == 1) {
      _paymentSelection = [true, false];
    } else {
      _paymentSelection = [true];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Process delivery'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _senderOption,
            _receiverOption,
            _deliveryNoteOption,
            _paymentOption,
            _nextButton,
          ],
        ),
      ),
    );
  }

  Widget get _senderOption {
    return Visibility(
      visible: widget._deliveryType == 1 || widget._deliveryType == 2,
      child: Container(
        margin: EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                isDense: true,
                labelText: "Sender's fullname",
                labelStyle: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                isDense: true,
                labelText: "Sender's phone number",
                labelStyle: Theme.of(context).textTheme.bodyText2,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget get _deliveryNoteOption {
    return Container(
      margin: EdgeInsets.only(top: 8.0, left: 16.0),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          textStyle: Theme.of(context).textTheme.button,
        ),
        onPressed: () {},
        icon: Icon(
          MdiIcons.plus,
          size: 16.0,
        ),
        label: Text('Add a delivery note'),
      ),
    );
  }

  Widget get _receiverOption {
    return Visibility(
      visible: widget._deliveryType == 0 || widget._deliveryType == 2,
      child: Container(
        margin: EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                isDense: true,
                labelText: "Receiver's fullname",
                labelStyle: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                isDense: true,
                labelText: "Receiver's phone number",
                labelStyle: Theme.of(context).textTheme.bodyText2,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget get _paymentOption {
    return Container(
      padding: EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Select payment method:',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ToggleButtons(
              isSelected: _paymentSelection,
              children: _paymentSelectionsWidgets,
              onPressed: (i) {
                setState(() {
                  for (int index = 0;
                      index < _paymentSelection.length;
                      index++) {
                    if (index == i) {
                      _paymentSelection[index] = true;
                      _paymentIndex = index;
                    } else {
                      _paymentSelection[index] = false;
                    }
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> get _paymentSelectionsWidgets {
    List<Widget> content = [];
    if (widget._taskType == 1) {
      content.addAll([
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text.rich(
            TextSpan(
              text: 'Cash',
              style: Theme.of(context).textTheme.bodyText2,
              children: [
                WidgetSpan(
                  child: Icon(
                    MdiIcons.cash,
                    size: 16.0,
                    color: Colors.blue[900],
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
          child: Text.rich(
            TextSpan(
              text: 'Card  ',
              style: Theme.of(context).textTheme.bodyText2,
              children: [
                WidgetSpan(
                  child: Icon(
                    MdiIcons.creditCard,
                    size: 16.0,
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
              text: 'Cash',
              style: Theme.of(context).textTheme.bodyText2,
              children: [
                WidgetSpan(
                  child: Icon(
                    MdiIcons.cash,
                    size: 16.0,
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
          
        },
        icon: Icon(MdiIcons.chevronRight),
        label: Text(''),
      ),
    );
  }
}
