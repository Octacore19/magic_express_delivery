import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:quiver/async.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _passwordObscured = true;
  bool _confirmPasswordObscured = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
              /*_headerWidget,
              _firstNameWidget,
              _lastNameWidget,
              _emailWidget,
              _phoneNumberWidget,
              _passwordWidget,
              _confirmPasswordWidget,
              _createButton,*/
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
        'Create account',
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
        controller: _firstNameController,
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
        controller: _lastNameController,
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
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        cursorColor: Theme.of(context).primaryColorDark,
        validator: _validateEmail,
        autovalidateMode: AutovalidateMode.onUserInteraction,
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

  Widget get _phoneNumberWidget {
    return Container(
      margin: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 8.0,
        top: 16.0,
      ),
      child: TextFormField(
        controller: _phoneNumberController,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        cursorColor: Theme.of(context).primaryColorDark,
        validator: _validatePhoneNumber,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: 'phone number',
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
        controller: _passwordController,
        cursorColor: Theme.of(context).primaryColorDark,
        obscureText: _passwordObscured,
        textInputAction: TextInputAction.next,
        obscuringCharacter: '*',
        validator: _validatePassword,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          isDense: true,
          hintText: 'password',
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
        controller: _confirmPasswordController,
        cursorColor: Theme.of(context).primaryColorDark,
        obscureText: _confirmPasswordObscured,
        textInputAction: TextInputAction.done,
        obscuringCharacter: '*',
        validator: _validateConfirmPassword,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          isDense: true,
          hintText: 'confirm Password',
          focusColor: Theme.of(context).primaryColorDark,
          suffixIcon: InkWell(
            child: Icon(
              _confirmPasswordObscured ? MdiIcons.eye : MdiIcons.eyeOff,
              color: Theme.of(context).primaryColorDark,
            ),
            onTap: () {
              _confirmPasswordObscured = !_confirmPasswordObscured;
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

  /*Widget get _createButton {
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listener: (_, _state) {
        _state.whenPartial(
          registrationError: (err) =>
              ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(err.message)),
          ),
          registrationSuccess: (success) {
            CountdownTimer(Duration(seconds: 3), Duration(seconds: 1))
                .listen((event) {
              if (event.elapsed.inSeconds == 3) {
                Navigator.pop(context);
                Navigator.pop(context);
              }
            });
            showDialog(
              context: context,
              builder: (_context) {
                return AlertDialog(
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 48.0,
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          success.message,
                          style: Theme.of(context).textTheme.headline6,
                        )
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                );
              },
            );
          },
        );
      },
      builder: (_, _state) {
        return Container(
          margin: EdgeInsets.only(
            top: 24.0,
            left: 16.0,
            right: 16.0,
          ),
          width: double.infinity,
          child: ElevatedButton(
            child: _state.whenOrElse(
              orElse: (_) => Text('Create'),
              registrationLoading: () => SizedBox.fromSize(
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
                registrationLoading: () => Colors.transparent,
              ),
            ),
            onPressed: _state.whenOrElse(
              orElse: (_) => _onRegisterPressed,
              registrationLoading: null,
            ),
          ),
        );
      },
    );
  }*/

  /*void _onRegisterPressed() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<RegistrationBloc>(context).add(
        RegistrationEvents.registerUser(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          phoneNumber: _phoneNumberController.text.trim(),
          confirmPassword: _confirmPasswordController.text.trim(),
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
        ),
      );
    }
  }*/

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    } else if (!EmailValidator.validate(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
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

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text.trim()) {
      return 'Please enter your password';
    }
    return null;
  }
}
