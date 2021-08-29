import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

part 'options_views.dart';

class OptionsPage extends StatelessWidget {
  static Page page() => MaterialPage<void>(child: OptionsPage());

  static Route route([Object? args]) => AppRoutes.generateRoute(
        OptionsPage(),
        fullScreenDialog: true,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Options'),
      ),
      body: BlocProvider(
        create: (context) => OptionsCubit(
          coordinator: BlocProvider.of(context),
        ),
        child: _Option(),
      ),
    );
  }
}

class _Option extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          _PersonnelOptionsView(),
          const SizedBox(height: 56),
          _ContinueButton(),
        ],
      ),
    );
  }
}
