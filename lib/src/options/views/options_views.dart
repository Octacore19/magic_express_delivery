import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/errand/views/errand_page.dart';
import 'package:magic_express_delivery/src/options/options.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PersonnelOptionsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
        BlocBuilder<OptionsCubit, OptionsState>(
          builder: (context, state) => SizedBox(
            width: double.infinity,
            child: ToggleButtons(
              direction: Axis.vertical,
              isSelected: state.personnelSelection,
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
              onPressed: (i) =>
                  context.read<OptionsCubit>().onPersonnelSelected(i),
            ),
          ),
        ),
      ],
    );
  }

  Widget _personnelDisplay(String title, String subtitle, IconData icon) {
    return Builder(
      builder: (context) => Container(
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
      ),
    );
  }
}

class ContinueButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionsCubit, OptionsState>(
      builder: (context, s) => SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(12.0),
            textStyle: Theme.of(context).textTheme.button,
          ),
          onPressed: !s.personnelSelected ? null : () {
            if (s.position == 0) {
              Navigator.of(context).push(ErrandPage.route(context));
              /*Navigator.pushNamed(
                context,
                AppRoutes.ERRAND,
                arguments: [widget.position, 0, _personnelIndex],
              );*/
            } else {
              /*Navigator.pushNamed(
                context,
                AppRoutes.DELIVERY,
                arguments: [widget.position, 0, _personnelIndex],
              );*/
            }
          },
          icon: Icon(MdiIcons.chevronRight),
          label: Text(''),
        ),
      ),
    );
  }
}
