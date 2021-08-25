import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/options/options.dart';
import 'package:repositories/repositories.dart';

class GreetingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocSelector<AppBloc, AppState, User>(
          selector: (s) => s.user,
          builder: (context, user) {
            if (user.isNotEmpty) {
              return Text(
                _generateGreeting() + ', ${user.firstName} ${user.lastName}!',
                style: Theme.of(context).textTheme.headline6,
              );
            }
            return Text(
              _generateGreeting() + ', John Doe!',
              style: Theme.of(context).textTheme.headline6,
            );
          },
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          'How can I help you today?',
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }

  String _generateGreeting() {
    final now = DateTime.now();
    if (now.isAfter(DateTime(now.year, now.month, now.day, 11, 59)) &&
        now.isBefore(DateTime(now.year, now.month, now.day, 18))) {
      return 'Good afternoon';
    } else if (now.isAfter(DateTime(now.year, now.month, now.day, 17, 59)) &&
        now.isBefore(DateTime(now.year, now.month, now.day, 21))) {
      return 'Good evening';
    } if (now.isAfter(DateTime(now.year, now.month, now.day, 20, 59)) ||
        now.isBefore(DateTime(now.year, now.month, now.day, 3))) {
      return 'Good afternoon';
    }
    return 'Good morning';
  }
}

class ErrandCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Card(
        shadowColor: Colors.blue[50],
        elevation: 6.0,
        margin: EdgeInsets.only(top: 36.0),
        child: InkWell(
          child: Container(
            padding: EdgeInsets.only(left: 36.0, right: 36.0, top: 16.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/shopping_cart.png',
                  fit: BoxFit.none,
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.2,
                  color: Theme.of(context).primaryColor,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Send on errand?',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.of(context).push(OptionsPage.route(0));
          },
        ),
      ),
    );
  }
}

class DeliveryCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Card(
        shadowColor: Colors.blue[50],
        elevation: 6.0,
        margin: EdgeInsets.only(top: 36.0),
        child: InkWell(
          child: Container(
            padding: EdgeInsets.only(left: 36.0, right: 36.0, top: 16.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/dispatch_rider.png',
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.2,
                  color: Theme.of(context).primaryColor,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Make a delivery?',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.of(context).push(OptionsPage.route(1));
          },
        ),
      ),
    );
  }
}
