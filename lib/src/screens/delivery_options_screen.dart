import 'package:flutter/material.dart';
import 'package:magic_express_delivery/src/index.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DeliveryOptionsScreen extends StatefulWidget {
  final int position;

  DeliveryOptionsScreen(this.position);

  @override
  State<StatefulWidget> createState() => _DeliveryOptionsScreenState();
}

class _DeliveryOptionsScreenState extends State<DeliveryOptionsScreen> {
  List<bool> _vehicleSelection = [false, false];
  List<bool> _personnelSelection = [false, false, false];
  late int _vehicleIndex;
  late int _personnelIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Options',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _vehicleOption,
            _personnelOption,
            _continueButton,
          ],
        ),
      ),
    );
  }

  Widget get _vehicleOption {
    final widget = Container(
      padding: EdgeInsets.only(left: 16.0, top: 36.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Vehicle Option:',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ToggleButtons(
              direction: Axis.vertical,
              isSelected: _vehicleSelection,
              children: [
                Icon(
                  MdiIcons.bikeFast,
                  color: Colors.blue[700],
                ),
                Icon(
                  MdiIcons.car,
                  color: Colors.blue[700],
                ),
              ],
              onPressed: (i) {
                setState(() {
                  for (int index = 0;
                      index < _vehicleSelection.length;
                      index++) {
                    if (index == i) {
                      _vehicleSelection[index] = true;
                      _vehicleIndex = index;
                    } else {
                      _vehicleSelection[index] = false;
                    }
                  }
                });
              },
            ),
          )
        ],
      ),
    );
    return widget;
  }

  Widget get _personnelOption {
    final widget = Container(
      padding: EdgeInsets.only(left: 16.0, top: 56.0, right: 16.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Personnel Option:',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ToggleButtons(
              direction: Axis.vertical,
              isSelected: _personnelSelection,
              children: [
                _personnelDisplay(
                  'Sender',
                  'Delivery request from me.',
                  MdiIcons.gift,
                ),
                _personnelDisplay(
                  'Receiver',
                  'Delivery request to me.',
                  MdiIcons.humanGreeting,
                ),
                _personnelDisplay(
                  'Third Party',
                  "Making request on someone's behalf.",
                  MdiIcons.tab,
                ),
              ],
              onPressed: (i) {
                setState(() {
                  for (int index = 0;
                      index < _personnelSelection.length;
                      index++) {
                    if (index == i) {
                      _personnelSelection[index] = true;
                      _personnelIndex = index;
                    } else {
                      _personnelSelection[index] = false;
                    }
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
    return widget;
  }

  Widget get _continueButton {
    Widget container = Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 56.0, right: 16.0, left: 16.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(12.0),
          textStyle: Theme.of(context).textTheme.button,
        ),
        onPressed: () {
          final _veh =
              _vehicleSelection.where((element) => element == true).toList();
          final _per =
              _personnelSelection.where((element) => element == true).toList();
          if (_veh.isNotEmpty && _per.isNotEmpty) {
            if (widget.position == 0) {
              Navigator.pushNamed(
                context,
                Routes.ERRAND,
                arguments: [_vehicleIndex, _personnelIndex],
              );
            } else {
              Navigator.pushNamed(
                context,
                Routes.DELIVERY,
                arguments: [_vehicleIndex, _personnelIndex],
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Please select an option')),
            );
          }
        },
        icon: Icon(MdiIcons.chevronRight),
        label: Text(''),
      ),
    );
    return container;
  }

  Widget _personnelDisplay(String title, String subtitle, IconData icon) {
    Widget container = Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 16.0),
            child: Icon(
              icon,
              color: Colors.blue[700],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Container(
                margin: EdgeInsets.only(top: 8.0),
                child: Text(
                  subtitle,
                  style: Theme.of(context).textTheme.caption,
                ),
              )
            ],
          )
        ],
      ),
    );
    return container;
  }
}
