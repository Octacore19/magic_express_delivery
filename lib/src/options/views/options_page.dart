import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/options/options.dart';

import 'options_views.dart';

class OptionsPage extends StatelessWidget {
  final Object? args;

  OptionsPage(this.args);

  static Page page([Object? args]) =>
      MaterialPage<void>(child: OptionsPage(args));

  static Route route([Object? args]) =>
      AppRoutes.generateRoute(OptionsPage(args));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Options'),
      ),
      body: BlocProvider(
        create: (_) => OptionsCubit(),
        child: _Option(args),
      ),
    );
  }
}

class _Option extends StatelessWidget {
  _Option(this.args);

  final Object? args;

  @override
  Widget build(BuildContext context) {
    context.read<OptionsCubit>().setCurrentPosition(args);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const SizedBox(height: 16.0),
          PersonnelOptionsView(),
          const SizedBox(height: 56.0),
          ContinueButton(),
        ],
      ),
    );
  }
}
