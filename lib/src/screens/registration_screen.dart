import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerWidget,
              _firstNameWidget,
              _lastNameWidget,
              _emailWidget,
              _passwordWidget,
              _confirmPasswordWidget,
              _createButton,
            ],
          ),
        ),
      ),
    );
  }

  Widget get _headerWidget {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'create account',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget get _firstNameWidget {
    return Container(
      margin: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 32.0,
      ),
      child: TextFormField(
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        cursorColor: Theme.of(context).primaryColorDark,
        decoration: InputDecoration(
          isDense: true,
          hintText: 'first name',
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

  Widget get _lastNameWidget {
    return Container(
      margin: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 8.0,
        top: 16.0,
      ),
      child: TextFormField(
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        cursorColor: Theme.of(context).primaryColorDark,
        decoration: InputDecoration(
          isDense: true,
          hintText: 'last name',
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

  Widget get _emailWidget {
    return Container(
      margin: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 8.0,
        top: 16.0,
      ),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        cursorColor: Theme.of(context).primaryColorDark,
        decoration: InputDecoration(
          hintText: 'email',
          isDense: true,
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
        bottom: 8.0,
        top: 16.0,
      ),
      child: TextFormField(
        cursorColor: Theme.of(context).primaryColorDark,
        obscureText: _passwordVisible,
        textInputAction: TextInputAction.next,
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

  Widget get _confirmPasswordWidget {
    return Container(
      margin: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 8.0,
        top: 8.0,
      ),
      child: TextFormField(
        cursorColor: Theme.of(context).primaryColorDark,
        obscureText: _confirmPasswordVisible,
        textInputAction: TextInputAction.done,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          isDense: true,
          hintText: 'confirm Password',
          focusColor: Theme.of(context).primaryColorDark,
          suffixIcon: InkWell(
            child: Icon(
              _confirmPasswordVisible ? MdiIcons.eye : MdiIcons.eyeOff,
              color: Theme.of(context).primaryColorDark,
            ),
            onTap: () {
              _confirmPasswordVisible = !_confirmPasswordVisible;
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

  Widget get _createButton {
    return Container(
      margin: EdgeInsets.only(
        top: 24.0,
        left: 16.0,
        right: 16.0,
      ),
      width: double.infinity,
      child: ElevatedButton(
        child: Text('create'),
        style: ElevatedButton.styleFrom(
          textStyle: Theme.of(context).textTheme.button,
          padding: EdgeInsets.all(16.0),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
