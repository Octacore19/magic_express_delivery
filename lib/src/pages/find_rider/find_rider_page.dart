import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/pages/find_rider/finder_rider_cubit.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:url_launcher/url_launcher.dart';

class FindRiderPage extends StatefulWidget {
  const FindRiderPage();

  static Route route() {
    return AppRoutes.generateRoute(
      child: BlocProvider(
        create: (context) => FindRiderCubit(
          repo: RepositoryProvider.of(context),
        ),
        child: FindRiderPage(),
      ),
      fullScreenDialog: true,
    );
  }

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<FindRiderPage> with SingleTickerProviderStateMixin {
  late Animation<double> _angleAnimation;

  late Animation<double> _scaleAnimation;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    final state = context.read<FindRiderCubit>().state;

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
        if (state.loading) {
          _controller.reverse();
        }
      } else if (status == AnimationStatus.dismissed) {
        if (state.loading) {
          _controller.forward();
        }
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: BlocBuilder<FindRiderCubit, FindRiderState>(
            builder: (_, state) {
              if (state.loading) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildAnimation(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2),
                      Text(
                        'Please wait while we find a rider for you',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
              }
              final rider = state.detail.rider;
              return SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                            ),
                          ),
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text(
                            'Find your Dispatch Rider',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Image(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.height * 0.4,
                          image: AssetImage(AppImages.DRIVER_IMAGE),
                          colorBlendMode: BlendMode.dst,
                        ),
                        const SizedBox(height: 32),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${rider.firstName} ${rider.lastName}',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8, top: 8),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            rider.email,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8, top: 8),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'has been assigned to your order',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 8, bottom: 8, top: 24),
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () async {
                              final number = 'tel://${rider.phoneNumber}';
                              await launch(number);
                            },
                            icon: Icon(Icons.phone),
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                DashboardPage.route(),
                                (route) => false,
                              );
                            },
                            style: TextButton.styleFrom(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(fontWeight: FontWeight.w700),
                                padding: EdgeInsets.symmetric(vertical: 16)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }

  Widget _buildAnimation() {
    double circleWidth = 10.0 * _scaleAnimation.value;
    Widget circles = new Container(
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
