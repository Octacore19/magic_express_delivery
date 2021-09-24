import 'package:flutter/material.dart';

class RiderHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            labelColor: Theme.of(context).primaryColorDark,
            labelStyle: Theme.of(context).textTheme.bodyText2,
            indicatorColor: Theme.of(context).primaryColorDark,
            unselectedLabelColor: Colors.grey,
            unselectedLabelStyle: Theme.of(context).textTheme.bodyText2,
            enableFeedback: true,
            tabs: [
              Tab(text: 'NEW REQUESTS'),
              Tab(text: 'COMPLETED REQUESTS')
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                Container(),
                Container()
              ],
            ),
          )
        ],
      ),
    );
  }
}
