import 'package:flutter/material.dart';
import 'package:magic_express_delivery/commons/commons.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

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
          Text('Login to account',
              style: Theme.of(context).textTheme.headline5),
        ],
      ),
    );
  }

  Widget get _emailWidget {
    return Container(
      margin: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 32.0,
      ),
      child: TextFormField(
        cursorColor: Theme.of(context).primaryColorDark,
        decoration: InputDecoration(
          hintText: 'Email',
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
        top: 32.0,
      ),
      child: TextFormField(
        cursorColor: Theme.of(context).primaryColorDark,
        obscureText: true,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          hintText: 'Password',
          focusColor: Theme.of(context).primaryColorDark,
          suffixIcon: Icon(
            Icons.remove_red_eye,
            color: Theme.of(context).primaryColorDark,
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
        ),
      ),
    );
  }

  Widget get _loginButton {
    return Container(
      margin: EdgeInsets.only(
        top: 32.0,
        left: 16.0,
        right: 16.0,
      ),
      width: double.infinity,
      child: ElevatedButton(
        child: Text('LOGIN'),
        style: ElevatedButton.styleFrom(
          textStyle: Theme.of(context).textTheme.button,
          padding: EdgeInsets.all(16.0),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget get _registerButton {
    return Container(
      margin: EdgeInsets.only(right: 16.0),
      alignment: Alignment.centerRight,
      child: TextButton(
        child: Text('Not registered? Click here!'),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            Routes.REGISTRATION,
          );
        },
      ),
    );
  }
}
