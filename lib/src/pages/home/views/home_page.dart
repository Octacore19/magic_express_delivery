import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/models/models.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:repositories/repositories.dart';

part 'home_views.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final isRider = context.read<AppBloc>().state.isRider;
    if (isRider) return BlocProvider(
      create: (context) => RiderHomeCubit(
        errorHandler: RepositoryProvider.of(context),
        ridersRepo: RepositoryProvider.of(context)
      ),
      child: RiderHome(),
    );
    return SingleChildScrollView(
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
    );
  }
}