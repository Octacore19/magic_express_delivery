import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:magic_express_delivery/src/utils/utils.dart';
import 'package:magic_express_delivery/src/widgets/widgets.dart';
import 'package:repositories/repositories.dart';

class UserDash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<UserDash> {
  @override
  Widget build(BuildContext context) {
    int position = context.watch<UserDashCubit>().state.position;
    return BlocProvider(
      create: (context) => HistoryBloc(
        ordersRepo: RepositoryProvider.of(context),
        errorHandler: RepositoryProvider.of(context),
      ),
      child: Scaffold(
        appBar: AppBar(
          actions: _actionBars(position),
        ),
        body: DoubleBackToCloseWidget(
          child: _pages[position],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedIconTheme: IconThemeData(color: Colors.blue[900], size: 32),
          selectedItemColor: Colors.blue[900],
          unselectedIconTheme: IconThemeData(color: Colors.grey, size: 24),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) => context.read<UserDashCubit>().setCurrentPage(index),
          currentIndex: context.read<UserDashCubit>().state.position,
          enableFeedback: true,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_rounded),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: '',
            ),
          ],
        ),
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
    }
  }

  final List<Widget> _pages = [
    UserHomePage(),
    HistoryPage(),
    ProfilePage(),
  ];
}
