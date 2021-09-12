import 'package:flutter/material.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/models/models.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:repositories/repositories.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(71, 136, 255, 1.0),
      body: Center(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (_, state) async {
            await Future.delayed(Duration(seconds: 5));
            if (state.status == AuthStatus.loggedIn) {
              Navigator.of(context).pushReplacement(DashboardPage.route());
            } else if (state.status == AuthStatus.loggedOut) {
              Navigator.of(context).pushReplacement(LoginPage.route());
            }
          },
          child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    );
  }
}
