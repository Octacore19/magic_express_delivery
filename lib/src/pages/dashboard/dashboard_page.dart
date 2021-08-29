import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage();

  static Page route() => MaterialPage<void>(
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
      appBar: AppBar(),
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

  final List<Widget> _pages = [
    HomePage(),
    HistoryPage(),
    ProfilePage(),
  ];
}
