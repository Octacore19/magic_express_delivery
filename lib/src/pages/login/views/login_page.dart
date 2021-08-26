import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

part 'login_views.dart';

class LoginPage extends StatelessWidget {
  const LoginPage();

  static Page route() => const MaterialPage<void>(child: const LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (_) => LoginBloc(authRepo: RepositoryProvider.of(context)),
        child: _LoginForm(),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<LoginBloc>().add(LoginEmailUnFocused());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<LoginBloc>().add(LoginPasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          String msg =
          state.message.isEmpty ? 'Login failure' : state.message;
          SnackBar snack = SnackBar(content: Text(msg));
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snack);
        }
      },
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 72),
            child: Column(
              children: [
                headerWidget(),
                const SizedBox(height: 24.0),
                _EmailInput(_emailFocusNode),
                const SizedBox(height: 24.0),
                _PasswordInput(_passwordFocusNode),
                const SizedBox(height: 96.0),
                _SubmitButton(),
                const SizedBox(height: 16.0),
                _RegistrationButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget headerWidget() {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        'Login to account',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
