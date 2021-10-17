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
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state.order.orderId.isNotEmpty) {
          final action = HistoryActions.fetchHistoryDetail;
          final event = HistoryEvent(action, state.order);
          context.read<HistoryBloc>().add(event);
          Navigator.of(context).push(HistoryDetailPage.route(context));
        }
      },
      child: SingleChildScrollView(
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
      ),
    );
  }
}
