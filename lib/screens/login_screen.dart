import 'package:flutter/material.dart';
import 'package:magic_express_delivery/commons/commons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

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
            'login to account',
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
        top: 32.0,
      ),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        cursorColor: Theme.of(context).primaryColorDark,
        decoration: InputDecoration(
          isDense: true,
          hintText: 'email',
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
        top: 16.0,
      ),
      child: TextFormField(
        cursorColor: Theme.of(context).primaryColorDark,
        textInputAction: TextInputAction.done,
        obscureText: _passwordVisible,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          isDense: true,
          hintText: 'password',
          focusColor: Theme.of(context).primaryColorDark,
          suffixIcon: InkWell(
            child: Icon(
              _passwordVisible ? MdiIcons.eye : MdiIcons.eyeOff,
              color: Theme.of(context).primaryColorDark,
            ),
            onTap: () {
              _passwordVisible = !_passwordVisible;
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
        child: Text('login'),
        style: ElevatedButton.styleFrom(
          textStyle: Theme.of(context).textTheme.button,
          padding: EdgeInsets.all(16.0),
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, Routes.DASHBOARD);
        },
      ),
    );
  }

  Widget get _registerButton {
    return Container(
      margin: EdgeInsets.only(right: 16.0),
      alignment: Alignment.centerRight,
      child: TextButton(
        child: Text('not registered? click here!'),
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
