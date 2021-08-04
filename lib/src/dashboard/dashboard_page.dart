import 'package:flutter/material.dart';
import 'package:magic_express_delivery/src/dashboard/dashboard_views.dart';

class DashboardPage extends StatelessWidget {

  const DashboardPage();

  static Page route() => const MaterialPage<void>(child: const DashboardPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GreetingsView(),
              ErrandCardView(),
              DeliveryCardView(),
            ],
          ),
        ),
      ),
    );
  }
}