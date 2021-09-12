part of 'registration_page.dart';

class _FirstNameInput extends StatelessWidget {
  const _FirstNameInput(this.node);

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
    final error =
        context.select((RegistrationBloc b) => b.state.firstName).error;
    return InputDecoration(
      prefixIcon: Icon(Icons.person, color: primaryColor),
      focusColor: primaryColor,
      hintText: 'First name',
      errorText: getError(error),
      hintStyle: Theme.of(context).textTheme.caption,
      focusedBorder: AppTheme.textOutlineFocusedBorder(context),
      enabledBorder: AppTheme.textOutlineEnabledBorder(context),
      errorBorder: AppTheme.textOutlineErrorBorder(context),
      focusedErrorBorder: AppTheme.textOutlineFocusedBorder(context),
    );
  }

  String? getError(NameValidationError? error) {
    if (error == NameValidationError.empty && node.hasFocus) {
      return 'Enter your first name';
    }
    return null;
  }
}

class _LastNameInput extends StatelessWidget {
  const _LastNameInput(this.node);

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
    final error =
        context.select((RegistrationBloc b) => b.state.lastName).error;
    return InputDecoration(
      focusColor: primaryColor,
      prefixIcon: Icon(Icons.person, color: primaryColor),
      hintText: 'Last name',
      errorText: getError(error),
      hintStyle: Theme.of(context).textTheme.caption,
      focusedBorder: AppTheme.textOutlineFocusedBorder(context),
      enabledBorder: AppTheme.textOutlineEnabledBorder(context),
      errorBorder: AppTheme.textOutlineErrorBorder(context),
      focusedErrorBorder: AppTheme.textOutlineFocusedBorder(context),
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

class _EmailInput extends StatelessWidget {
  const _EmailInput(this.node);

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
    final error = context.select((RegistrationBloc b) => b.state.email).error;
    return InputDecoration(
      prefixIcon: Icon(Icons.email, color: primaryColor),
      focusColor: primaryColor,
      hintText: 'Email',
      errorText: getError(error),
      hintStyle: Theme.of(context).textTheme.caption,
      focusedBorder: AppTheme.textOutlineFocusedBorder(context),
      enabledBorder: AppTheme.textOutlineEnabledBorder(context),
      errorBorder: AppTheme.textOutlineErrorBorder(context),
      focusedErrorBorder: AppTheme.textOutlineFocusedBorder(context),
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

class _PhoneNumberInput extends StatelessWidget {
  const _PhoneNumberInput(this.node);

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
    final error =
        context.select((RegistrationBloc b) => b.state.phoneNumber).error;
    return InputDecoration(
      focusColor: primaryColor,
      prefixIcon: Icon(Icons.phone, color: primaryColor),
      hintText: 'Phone number',
      errorText: getError(error),
      hintStyle: Theme.of(context).textTheme.caption,
      focusedBorder: AppTheme.textOutlineFocusedBorder(context),
      enabledBorder: AppTheme.textOutlineEnabledBorder(context),
      errorBorder: AppTheme.textOutlineErrorBorder(context),
      focusedErrorBorder: AppTheme.textOutlineFocusedBorder(context),
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

class _PasswordInput extends StatelessWidget {
  const _PasswordInput(this.node, [this.next]);

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
    final error =
        context.select((RegistrationBloc b) => b.state.password).error;
    return InputDecoration(
      prefixIcon: Icon(Icons.password, color: primaryColor),
      hintText: 'Password',
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
      focusedBorder: AppTheme.textOutlineFocusedBorder(context),
      enabledBorder: AppTheme.textOutlineEnabledBorder(context),
      errorBorder: AppTheme.textOutlineErrorBorder(context),
      focusedErrorBorder: AppTheme.textOutlineFocusedBorder(context),
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

class _ConfirmPasswordInput extends StatelessWidget {
  const _ConfirmPasswordInput(this.node);

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
    final error =
        context.select((RegistrationBloc b) => b.state.confirmPassword).error;
    return InputDecoration(
      prefixIcon: Icon(Icons.password, color: primaryColor),
      hintText: 'Confirm password',
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
      focusedBorder: AppTheme.textOutlineFocusedBorder(context),
      enabledBorder: AppTheme.textOutlineEnabledBorder(context),
      errorBorder: AppTheme.textOutlineErrorBorder(context),
      focusedErrorBorder: AppTheme.textOutlineFocusedBorder(context),
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

class _CreateButton extends StatelessWidget {
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
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
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
