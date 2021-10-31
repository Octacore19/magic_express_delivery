import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:repositories/repositories.dart';

class PermissionScreen extends StatefulWidget {
  static Route route() {
    return AppRoutes.generateRouteBuilder(builder: (_) => PermissionScreen());
  }

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<PermissionScreen> {
  final _controller = StreamController<LocationPermission>();
  late StreamSubscription _listener;

  @override
  void initState() {
    super.initState();
    _listener = _controller.stream.listen((permission) {
      switch (permission) {
        case LocationPermission.denied:
          final snack = SnackBar(
              content:
                  Text('Please, enable permission to use device location'));
          ScaffoldMessenger.maybeOf(context)
            ?..hideCurrentSnackBar()
            ..showSnackBar(snack);
          // _requestLocationPermission();
          break;
        case LocationPermission.deniedForever:
          final snack = SnackBar(
            content: Text(
              'Location permissions are permanently denied, we cannot request permissions. '
              'Check phone settings to enable again.',
            ),
          );
          ScaffoldMessenger.maybeOf(context)
            ?..hideCurrentSnackBar()
            ..showSnackBar(snack);
          _navigate();
          break;
        case LocationPermission.whileInUse:
        case LocationPermission.always:
          _navigate();
          break;
      }
    });
  }

  @override
  void dispose() {
    _controller.close();
    _listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(AppImages.LOCATION_IMAGE),
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.2,
            ),
            const SizedBox(height: 8),
            Text(
              'This application needs your permission to access the location of this device, to be able to function properly.',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 96),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                child: Text('Enable Location'),
                onPressed: _requestLocationPermission,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _requestLocationPermission() async {
    final res = await Geolocator.requestPermission();
    print('Permission request result ========>>>>> $res');
    _controller.sink.add(res);
  }

  void _navigate() {
    final state = context.read<AppBloc>().state;
    if (state.status == AuthStatus.loggedIn) {
      Navigator.of(context).pushReplacement(DashboardPage.route());
    } else if (state.status == AuthStatus.loggedOut) {
      Navigator.of(context).pushReplacement(LoginPage.route());
    }
  }
}
