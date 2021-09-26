import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:magic_express_delivery/src/utils/utils.dart';
import 'package:magic_express_delivery/src/widgets/widgets.dart';
import 'package:repositories/repositories.dart';

class RiderDash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<RiderDash> {
  @override
  Widget build(BuildContext context) {
    int position = context.watch<RiderDashCubit>().state.pages.position;
    return Scaffold(
      appBar: AppBar(
        title: Text(position == 0 ? 'Requests' : ''),
        actions: _actionBars(position),
      ),
      body: DoubleBackToCloseWidget(
        child: _pages[position],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => context.read<RiderDashCubit>().setCurrentPage(index),
        currentIndex: context.read<RiderDashCubit>().state.pages.position,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_rounded),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  List<Widget>? _actionBars(int position) {
    if (position == 0) {
      return [
        BlocBuilder<RiderDashCubit, RiderDashState>(
          builder: (context, state) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Availability:',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: state.riderAvailability ? Colors.blue.shade900 : Colors.grey
                  ),
                ),
                SizedBox(width: 4.0),
                Switch.adaptive(
                  value: state.riderAvailability,
                  activeColor: Colors.white,
                  activeTrackColor: Colors.green,
                  inactiveTrackColor: Colors.red,
                  onChanged: (b) {
                    context.read<RiderDashCubit>().toggleRiderAvailability(b);
                  },
                ),
              ],
            );
          },
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        )
      ];
    } else if (position == 1) {
      return [
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                title: Text('Do you want to log out?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      context.read<AuthRepo>().logOut();
                      AppKeys.navigatorKey.currentState?.pushAndRemoveUntil(
                        LoginPage.route(),
                        (route) => false,
                      );
                    },
                    child: Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context, rootNavigator: true).pop(),
                    child: Text('No'),
                  )
                ],
              ),
            );
          },
          icon: Icon(Icons.exit_to_app),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        )
      ];
    }
  }

  final List<Widget> _pages = [
    HomePage(),
    ProfilePage(),
  ];
}