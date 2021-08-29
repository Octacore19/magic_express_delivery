import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:repositories/repositories.dart';

part 'home_views.dart';

class HomePage extends StatelessWidget {

  const HomePage();

  static Page route() => const MaterialPage<void>(child: const HomePage());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _GreetingsView(),
            _ErrandCardView(),
            _DeliveryCardView(),
          ],
        ),
      ),
    );
  }
}