import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:magic_express_delivery/src/utils/utils.dart';
import 'package:repositories/repositories.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage();

  static Page page() => MaterialPage<void>(
        child: BlocProvider(
          create: (_) => DashBoardCubit(),
          child: const DashboardPage(),
        ),
      );

  static Route route() => AppRoutes.generateRoute(
        child: BlocProvider(
          create: (_) => DashBoardCubit(),
          child: const DashboardPage(),
        ),
      );

  @override
  State<StatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    int position = context.watch<DashBoardCubit>().state.position;
    return Scaffold(
      appBar: AppBar(
        actions: _actionBars(position),
      ),
      body: _pages[position],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedIconTheme: IconThemeData(color: Colors.blue[900], size: 32),
        selectedItemColor: Colors.blue[900],
        unselectedIconTheme: IconThemeData(color: Colors.grey, size: 24),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) => context.read<DashBoardCubit>().setCurrentPage(index),
        currentIndex: context.read<DashBoardCubit>().state.position,
        enableFeedback: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: 'History',
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
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        )
      ];
    } else if (position == 2) {
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
    HistoryPage(),
    ProfilePage(),
  ];
}
