part of 'options_page.dart';

class _PersonnelOptionsView extends StatelessWidget {
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
            style: Theme
                .of(context)
                .textTheme
                .headline6,
          ),
        ),
        const SizedBox(height: 16),
        BlocBuilder<OptionsCubit, OptionsState>(
          builder: (context, state) =>
              SizedBox(
                width: double.infinity,
                child: ToggleButtons(
                  direction: Axis.vertical,
                  isSelected: state.personnelSelection,
                  // renderBorder: false,
                  children: [
                    _PersonnelDisplay(
                      title: 'Sender',
                      subtitle: 'Delivery request from me.',
                      icon: MdiIcons.gift,
                    ),
                    _PersonnelDisplay(
                      title: 'Receiver',
                      subtitle: 'Delivery request to me.',
                      icon: MdiIcons.humanGreeting,
                    ),
                    _PersonnelDisplay(
                      title: 'Third Party',
                      subtitle: "Making request on someone's behalf.",
                      icon: MdiIcons.tab,
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
}

class _PersonnelDisplay extends StatelessWidget {
  _PersonnelDisplay({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title, subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
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
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6,
              ),
              Container(
                margin: EdgeInsets.only(top: 8.0),
                child: Text(
                  subtitle,
                  style: Theme
                      .of(context)
                      .textTheme
                      .subtitle2,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionsCubit, OptionsState>(
      builder: (context, s) =>
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16),
                textStyle: Theme
                    .of(context)
                    .textTheme
                    .button,
              ),
              onPressed: !s.personnelSelected ? null : () {
                if (s.position == 0) {
                  Navigator.of(context).push(ErrandPage.route(context));
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
