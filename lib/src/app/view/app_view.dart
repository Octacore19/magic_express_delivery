import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/utils/utils.dart';
import 'package:repositories/repositories.dart';

class AppView extends StatelessWidget {
  const AppView();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppKeys.navigatorKey,
      title: 'Magic Express Delivery',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme(context),
      home: FlowBuilder<AuthStatus>(
        state: context.select((AuthBloc bloc) => bloc.state).status,
        onGeneratePages: AppRoutes.onGenerateAppViewPages,
      ),
    );
  }
}
