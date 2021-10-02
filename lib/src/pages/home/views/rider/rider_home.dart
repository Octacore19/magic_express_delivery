import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/pages/home/home.dart';

class RiderHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RiderHomeCubit(
        errorHandler: RepositoryProvider.of(context),
        ridersRepo: RepositoryProvider.of(context),
      ),
      child: LayoutBuilder(
        builder: (context, _) => DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                labelColor: Theme.of(context).primaryColorDark,
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(fontWeight: FontWeight.w700),
                indicatorColor: Theme.of(context).primaryColorDark,
                unselectedLabelColor: Colors.grey,
                unselectedLabelStyle: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(fontWeight: FontWeight.w700),
                enableFeedback: true,
                tabs: [
                  Tab(text: 'NEW REQUESTS'),
                  Tab(text: 'COMPLETED REQUESTS')
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TabBarView(
                    children: [
                      NewRiderRequests(),
                      CompletedRiderRequests(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
