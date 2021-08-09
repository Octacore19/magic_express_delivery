import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:magic_express_delivery/src/login/login.dart';
import 'package:magic_express_delivery/src/registration/registration.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FirstNameInput extends StatelessWidget {
  const FirstNameInput(this.node);

  final FocusNode node;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegistrationBloc, RegistrationState, Name>(
      selector: (s) => s.firstName,
      builder: (context, s) => TextFormField(
        initialValue: s.value,
        focusNode: node,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        cursorColor: Theme.of(context).primaryColorDark,
        onChanged: (v) {
          final event = RegistrationEvent(
            action: RegistrationEvents.FirstNameChanged,
            arguments: v,
          );
          context.read<RegistrationBloc>().add(event);
        },
        decoration: setInputDecoration(context),
      ),
    );
  }

  InputDecoration setInputDecoration(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColorDark;
    final errorColor = Theme.of(context).errorColor;
    final error =
        context.select((RegistrationBloc b) => b.state.firstName).error;
    return InputDecoration(
      isDense: true,
      prefixIcon: Icon(Icons.person, color: primaryColor),
      focusColor: primaryColor,
      hintText: 'first name',
      errorText: getError(error),
      hintStyle: Theme.of(context).textTheme.caption,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.0, color: primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: errorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.0, color: errorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    );
  }

  String? getError(NameValidationError? error) {
    if (error == NameValidationError.empty && node.hasFocus) {
      return 'Enter your first name';
    }
    return null;
  }
}

class LastNameInput extends StatelessWidget {
  const LastNameInput(this.node);

  final FocusNode node;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegistrationBloc, RegistrationState, Name>(
      selector: (s) => s.lastName,
      builder: (context, s) => TextFormField(
        initialValue: s.value,
        focusNode: node,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        cursorColor: Theme.of(context).primaryColorDark,
        onChanged: (v) {
          final event = RegistrationEvent(
            action: RegistrationEvents.LastNameChanged,
            arguments: v,
          );
          context.read<RegistrationBloc>().add(event);
        },
        decoration: setInputDecoration(context),
      ),
    );
  }

  InputDecoration setInputDecoration(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColorDark;
    final errorColor = Theme.of(context).errorColor;
    final error =
        context.select((RegistrationBloc b) => b.state.lastName).error;
    return InputDecoration(
      isDense: true,
      focusColor: primaryColor,
      prefixIcon: Icon(Icons.person, color: primaryColor),
      hintText: 'last name',
      errorText: getError(error),
      hintStyle: Theme.of(context).textTheme.caption,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.0, color: primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: errorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.0, color: errorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    );
  }

  String? getError(NameValidationError? error) {
    if (error == NameValidationError.empty) {
      if (node.hasFocus) {
        return 'Enter your last name';
      }
    }
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput(this.node);

  final FocusNode node;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegistrationBloc, RegistrationState, Email>(
      selector: (s) => s.email,
      builder: (context, state) => TextFormField(
        initialValue: state.value,
        focusNode: node,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        cursorColor: Theme.of(context).primaryColorDark,
        onChanged: (email) {
          final event = RegistrationEvent(
            action: RegistrationEvents.EmailChanged,
            arguments: email,
          );
          context.read<RegistrationBloc>().add(event);
        },
        decoration: setInputDecoration(context),
      ),
    );
  }

  InputDecoration setInputDecoration(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColorDark;
    final errorColor = Theme.of(context).errorColor;
    final error = context.select((RegistrationBloc b) => b.state.email).error;
    return InputDecoration(
      isDense: true,
      prefixIcon: Icon(Icons.email, color: primaryColor),
      focusColor: primaryColor,
      hintText: 'email',
      errorText: getError(error),
      hintStyle: Theme.of(context).textTheme.caption,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.0, color: primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: errorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.0, color: errorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    );
  }

  String? getError(EmailValidationError? error) {
    switch (error) {
      case EmailValidationError.invalid:
        return 'Invalid email';
      case EmailValidationError.empty:
        if (node.hasFocus)
          return 'Enter an email';
        else
          break;
      default:
        break;
    }
  }
}

class PhoneNumberInput extends StatelessWidget {
  const PhoneNumberInput(this.node);

  final FocusNode node;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegistrationBloc, RegistrationState, PhoneNumber>(
      selector: (s) => s.phoneNumber,
      builder: (context, s) => TextFormField(
        initialValue: s.value,
        focusNode: node,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        cursorColor: Theme.of(context).primaryColorDark,
        onChanged: (v) {
          final event = RegistrationEvent(
            action: RegistrationEvents.PhoneNumberChanged,
            arguments: v,
          );
          context.read<RegistrationBloc>().add(event);
        },
        decoration: setInputDecoration(context),
      ),
    );
  }

  InputDecoration setInputDecoration(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColorDark;
    final errorColor = Theme.of(context).errorColor;
    final error =
        context.select((RegistrationBloc b) => b.state.phoneNumber).error;
    return InputDecoration(
      isDense: true,
      focusColor: primaryColor,
      prefixIcon: Icon(Icons.phone, color: primaryColor),
      hintText: 'phone number',
      errorText: getError(error),
      hintStyle: Theme.of(context).textTheme.caption,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.0, color: primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: errorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.0, color: errorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    );
  }

  String? getError(PhoneNumberValidatorError? error) {
    if (error == PhoneNumberValidatorError.empty) {
      if (node.hasFocus) {
        return 'Enter your phone number';
      }
    }
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput(this.node, [this.next]);

  final FocusNode node;
  final FocusNode? next;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) => TextFormField(
        initialValue: state.password.value,
        focusNode: node,
        textInputAction: TextInputAction.next,
        obscureText: state.passwordObscured,
        obscuringCharacter: '*',
        onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(next),
        onChanged: (password) {
          final event = RegistrationEvent(
            action: RegistrationEvents.PasswordChanged,
            arguments: password,
          );
          context.read<RegistrationBloc>().add(event);
        },
        cursorColor: Theme.of(context).primaryColorDark,
        decoration: setInputDecoration(context, state.passwordObscured),
      ),
    );
  }

  InputDecoration setInputDecoration(
      BuildContext context, bool passwordObscured) {
    final primaryColor = Theme.of(context).primaryColorDark;
    final errorColor = Theme.of(context).errorColor;
    final error =
        context.select((RegistrationBloc b) => b.state.password).error;
    return InputDecoration(
      prefixIcon: Icon(Icons.password, color: primaryColor),
      isDense: true,
      hintText: 'password',
      focusColor: primaryColor,
      errorText: getError(error),
      hintStyle: Theme.of(context).textTheme.caption,
      suffixIcon: InkWell(
        child: Icon(
          passwordObscured ? MdiIcons.eye : MdiIcons.eyeOff,
          color: primaryColor,
        ),
        onTap: () {
          final event = RegistrationEvent(
            action: RegistrationEvents.PasswordObscured,
          );
          context.read<RegistrationBloc>().add(event);
        },
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.0, color: primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: errorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.0, color: errorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    );
  }

  String? getError(PasswordValidationError? error) {
    switch (error) {
      case PasswordValidationError.invalid:
        return 'Invalid password';
      case PasswordValidationError.empty:
        if (node.hasFocus)
          return 'Enter a password';
        else
          return null;
      default:
        return null;
    }
  }
}

class ConfirmPasswordInput extends StatelessWidget {
  const ConfirmPasswordInput(this.node);

  final FocusNode node;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) => TextFormField(
        initialValue: state.confirmPassword.value,
        focusNode: node,
        textInputAction: TextInputAction.done,
        obscureText: state.confirmPasswordObscured,
        obscuringCharacter: '*',
        onChanged: (password) {
          final event = RegistrationEvent(
            action: RegistrationEvents.ConfirmPasswordChanged,
            arguments: password,
          );
          context.read<RegistrationBloc>().add(event);
        },
        cursorColor: Theme.of(context).primaryColorDark,
        decoration: setInputDecoration(context, state.confirmPasswordObscured),
      ),
    );
  }

  InputDecoration setInputDecoration(
      BuildContext context, bool passwordObscured) {
    final primaryColor = Theme.of(context).primaryColorDark;
    final errorColor = Theme.of(context).errorColor;
    final error =
        context.select((RegistrationBloc b) => b.state.confirmPassword).error;
    return InputDecoration(
      prefixIcon: Icon(Icons.password, color: primaryColor),
      isDense: true,
      hintText: 'confirm password',
      focusColor: primaryColor,
      errorText: getError(error),
      hintStyle: Theme.of(context).textTheme.caption,
      suffixIcon: InkWell(
        child: Icon(
          passwordObscured ? MdiIcons.eye : MdiIcons.eyeOff,
          color: primaryColor,
        ),
        onTap: () {
          final event = RegistrationEvent(
            action: RegistrationEvents.ConfirmPasswordObscured,
          );
          context.read<RegistrationBloc>().add(event);
        },
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.0, color: primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: errorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.0, color: errorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    );
  }

  String? getError(ConfirmPasswordValidator? error) {
    switch (error) {
      case ConfirmPasswordValidator.no_match:
        return 'Password does not match';
      case ConfirmPasswordValidator.empty:
        if (node.hasFocus)
          return 'Enter a password';
        else
          return null;
      default:
        return null;
    }
  }
}

class CreateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (p, c) => p.status != c.status,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            child: Builder(
              builder: (_) {
                if (state.status.isSubmissionInProgress) {
                  return SizedBox.fromSize(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: primaryColor,
                    ),
                    size: Size(22.0, 22.0),
                  );
                }
                return Text('Create');
              },
            ),
            style: ElevatedButton.styleFrom(
              textStyle: Theme.of(context).textTheme.button,
              padding: EdgeInsets.all(16.0),
              primary: primaryColorSelect(context),
            ),
            onPressed: state.status.isValidated
                ? () {
                    FocusScope.of(context).unfocus();
                    final event = RegistrationEvent(
                        action: RegistrationEvents.CreateUser);
                    context.read<RegistrationBloc>().add(event);
                  }
                : null,
          ),
        );
      },
    );
  }

  Color primaryColorSelect(BuildContext context) {
    final primaryColorDark = Theme.of(context).primaryColorDark;
    final isLoading = context
        .select((RegistrationBloc b) => b.state.status)
        .isSubmissionInProgress;
    if (isLoading) return Colors.transparent;
    return primaryColorDark;
  }
}
