import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';

class ChangePasswordPage extends StatelessWidget {

  static Route route() => AppRoutes.generateRoute(
    child: ChangePasswordPage(),
    fullScreenDialog: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.blue.shade50,
      body: BlocProvider(
        create: (_) => ChangePasswordCubit(
          errorHandler: RepositoryProvider.of(context),
          miscRepo: RepositoryProvider.of(context)
        ),
        child: _Form(),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FormState();
}

class _FormState extends State<_Form> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        headerWidget(),
        const SizedBox(height: 8.0),
      ],
    );
  }

  Widget headerWidget() {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        'Change Password',
        style: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}