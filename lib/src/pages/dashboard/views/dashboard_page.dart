import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage();

  static Route route() {
    return AppRoutes.generateRouteBuilder(builder: (context) {
      final isRider = context.read<AppBloc>().state.isRider;
      if(isRider) {
        return BlocProvider(
          create: (_) => RiderDashCubit(),
          child: const DashboardPage(),
        );
      }
      return BlocProvider(
        create: (_) => UserDashCubit(),
        child: const DashboardPage(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isRider = context.read<AppBloc>().state.isRider;
    if (isRider) return RiderDash();
    return UserDash();
  }
}
