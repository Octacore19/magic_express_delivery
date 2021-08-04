import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen();

  static Page route() => const MaterialPage<void>(child: LoginScreen());

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordObscured = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerWidget,
            _emailWidget,
            _passwordWidget,
            _loginButton,
            _registerButton
          ],
        ),
      ),
    );
  }

  Widget get _headerWidget {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login to account',
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }

  Widget get _emailWidget {
    return Container(
      margin: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 48.0,
      ),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        cursorColor: Theme.of(context).primaryColorDark,
        validator: _validateEmail,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          isDense: true,
          hintText: 'email',
          hintStyle: Theme.of(context).textTheme.caption,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.0,
              color: Theme.of(context).primaryColorDark,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColorDark,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).errorColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.0,
              color: Theme.of(context).errorColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _passwordWidget {
    return Container(
      margin: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 16.0,
        top: 16.0,
      ),
      child: TextFormField(
        controller: _passwordController,
        cursorColor: Theme.of(context).primaryColorDark,
        textInputAction: TextInputAction.done,
        obscureText: _passwordObscured,
        obscuringCharacter: '*',
        validator: _validatePassword,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          isDense: true,
          hintText: 'password',
          hintStyle: Theme.of(context).textTheme.caption,
          focusColor: Theme.of(context).primaryColorDark,
          suffixIcon: InkWell(
            child: Icon(
              _passwordObscured ? MdiIcons.eye : MdiIcons.eyeOff,
              color: Theme.of(context).primaryColorDark,
            ),
            onTap: () {
              _passwordObscured = !_passwordObscured;
              setState(() {});
            },
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.0,
              color: Theme.of(context).primaryColorDark,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColorDark,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).errorColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.0,
              color: Theme.of(context).errorColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _loginButton {
    return Container();
    /*return BlocConsumer<LoginBloc, LoginState>(
      listener: (_, _state) {
        _state.whenPartial(
          loginSuccess: (user) => Navigator.pushReplacementNamed(
            context,
            Routes.DASHBOARD,
          ),
          loginError: (err) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(err.message)),
          ),
        );
      },
      builder: (_, _state) {
        return Container(
          margin: EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0),
          width: double.infinity,
          child: ElevatedButton(
            child: _state.whenOrElse(
              orElse: (_) => Text('Login'),
              loginLoading: () => SizedBox.fromSize(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                size: Size(22.0, 22.0),
              ),
            ),
            style: ElevatedButton.styleFrom(
              textStyle: Theme.of(context).textTheme.button,
              padding: EdgeInsets.all(16.0),
              primary: _state.whenOrElse(
                orElse: (_) => Theme.of(context).primaryColorDark,
                loginLoading: () => Colors.transparent,
              ),
            ),
            onPressed: _state.whenOrElse(
              orElse: (_) => _onLoginPressed,
              loginLoading: null,
            ),
          ),
        );
      },
    );*/
  }

  Widget get _registerButton {
    return Container(
      margin: EdgeInsets.only(right: 16.0),
      alignment: Alignment.center,
      child: TextButton(
        child: Text('Not registered? Click here!'),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          textStyle: Theme.of(context).textTheme.button,
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes.REGISTRATION,
          );
        },
      ),
    );
  }

  void _onLoginPressed() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    /*if (_formKey.currentState!.validate()) {
      context.read<LoginBloc>().add(
            LoginEvents.loginUser(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            ),
          );
    }*/
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    } else if (!EmailValidator.validate(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.isNotEmpty && value.length < 5) {
      return 'Password is too short';
    }
    return null;
  }
}
