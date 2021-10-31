import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/resources/resources.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:repositories/repositories.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({required this.isRider});

  final bool isRider;

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late bool _loadingInProgress;

  late Animation<double> _angleAnimation;

  late Animation<double> _scaleAnimation;

  late AnimationController _controller;

  @override
  void dispose() {
    _angleAnimation.removeListener(() {});
    _angleAnimation.removeStatusListener((status) {});
    _scaleAnimation.removeListener(() {});
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadingInProgress = true;

    _controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _angleAnimation = new Tween(begin: 0.0, end: 360.0).animate(_controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    _scaleAnimation = new Tween(begin: 1.0, end: 6.0).animate(_controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });

    _angleAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_loadingInProgress) {
          _controller.reverse();
        }
      } else if (status == AnimationStatus.dismissed) {
        if (_loadingInProgress) {
          _controller.forward();
        }
      }
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Center(
        child: BlocListener<AppBloc, AppState>(
          listener: (context, state) async {
            await Future.delayed(Duration(seconds: 10));
            setState(() {
              _loadingInProgress = false;
            });
            await Future.delayed(Duration(seconds: 2));
            if (widget.isRider) {
              bool enabled = await Geolocator.isLocationServiceEnabled();
              if (enabled) {
                final permission = await Geolocator.checkPermission();
                if (permission == LocationPermission.denied ||
                    permission == LocationPermission.deniedForever) {
                  Navigator.maybeOf(context)
                      ?.pushReplacement(PermissionScreen.route());
                } else {
                  if (state.status == AuthStatus.loggedIn) {
                    Navigator.of(context)
                        .pushReplacement(DashboardPage.route());
                  } else if (state.status == AuthStatus.loggedOut) {
                    Navigator.of(context).pushReplacement(LoginPage.route());
                  }
                }
              } else {
                final snack = SnackBar(
                    content: Text(
                  'Location services are disabled. Go to your phone settings to enable location services.',
                ));
                ScaffoldMessenger.maybeOf(context)
                  ?..hideCurrentSnackBar()
                  ..showSnackBar(snack);
                if (state.status == AuthStatus.loggedIn) {
                  Navigator.of(context).pushReplacement(DashboardPage.route());
                } else if (state.status == AuthStatus.loggedOut) {
                  Navigator.of(context).pushReplacement(LoginPage.route());
                }
              }
            } else {
              if (state.status == AuthStatus.loggedIn) {
                Navigator.of(context).pushReplacement(DashboardPage.route());
              } else if (state.status == AuthStatus.loggedOut) {
                Navigator.of(context).pushReplacement(LoginPage.route());
              }
            }
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(AppImages.MAGIC_LOGO),
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.width * .4,
                ),
                _buildAnimation(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimation() {
    double circleWidth = 10.0 * _scaleAnimation.value;
    Widget circles = new SizedBox(
      width: circleWidth * 2.0,
      height: circleWidth * 2.0,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Row(
            children: <Widget>[
              _buildCircle(circleWidth, Colors.blue),
              _buildCircle(circleWidth, Colors.blue.shade200),
            ],
          ),
          new Row(
            children: <Widget>[
              _buildCircle(circleWidth, Colors.blue),
              _buildCircle(circleWidth, Colors.blue.shade200),
            ],
          ),
        ],
      ),
    );

    double angleInDegrees = _angleAnimation.value;
    return new Transform.rotate(
      angle: angleInDegrees / 360 * 2 * pi,
      child: new Container(
        child: circles,
      ),
    );
  }

  Widget _buildCircle(double circleWidth, Color color) {
    return new Container(
      width: circleWidth,
      height: circleWidth,
      decoration: new BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
