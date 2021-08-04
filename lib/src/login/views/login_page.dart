import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:magic_express_delivery/src/login/bloc/login_bloc.dart';
import 'package:magic_express_delivery/src/login/views/login_views.dart';

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
    return SingleChildScrollView(
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == FormzStatus.submissionFailure) {
            String msg =
                state.message.isEmpty ? 'Login failure' : state.message;
            SnackBar snack = SnackBar(content: Text(msg));
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snack);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              headerWidget(),
              const SizedBox(height: 48.0),
              EmailInput(_emailFocusNode),
              const SizedBox(height: 16.0),
              PasswordInput(_passwordFocusNode),
              const SizedBox(height: 32.0),
              SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerWidget() {
    return Align(
      child: Text(
        'Login to account',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
