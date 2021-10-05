import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/models/models.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:repositories/repositories.dart';

part 'user_home_views.dart';

class UserHomePage extends StatelessWidget {
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