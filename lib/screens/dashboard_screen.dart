import 'package:flutter/material.dart';
import 'package:magic_express_delivery/commons/commons.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          _accountWidget,
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _greetingWidget,
          _errandCardWidget,
          _deliveryCardWidget,
        ],
      ),
    );
  }

  Widget get _accountWidget {
    return Container(
      margin: EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(context, Routes.DEFAULT);
        },
        borderRadius: BorderRadius.circular(36.0),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: Icon(Icons.more_horiz),
        ),
      ),
    );
  }

  Widget get _greetingWidget {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Good morning, John!',
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            'How can I help you today?',
            style: Theme.of(context).textTheme.subtitle1,
          )
        ],
      ),
    );
  }

  Widget get _errandCardWidget {
    return Align(
      alignment: Alignment.center,
      child: Card(
        margin: EdgeInsets.only(top: 36.0),
        child: InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 36.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/shopping_cart.jpg',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.2,
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
          onTap: () {},
        ),
      ),
    );
  }

  Widget get _deliveryCardWidget {
    return Align(
      alignment: Alignment.center,
      child: Card(
        margin: EdgeInsets.only(top: 36.0),
        child: InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 36.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/dispatch_rider.png',
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.2,
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
          onTap: () {},
        ),
      ),
    );
  }
}
