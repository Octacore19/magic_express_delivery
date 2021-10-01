import 'package:flutter/material.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:magic_express_delivery/src/utils/utils.dart';

class AppView extends StatelessWidget {
  const AppView();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppKeys.navigatorKey,
      title: 'Magic Express Delivery',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.userTheme,
      home: SplashScreen(),
    );
  }
}
