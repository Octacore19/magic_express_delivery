part of 'login_page.dart';

class _EmailInput extends StatelessWidget {
  const _EmailInput(this.node);

  final FocusNode node;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginBloc, LoginState, Email>(
      selector: (s) => s.email,
      builder: (context, state) => TextFormField(
        initialValue: state.value,
        focusNode: node,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        cursorColor: Theme.of(context).primaryColorDark,
        onChanged: (email) =>
            context.read<LoginBloc>().add(LoginEmailChanged(email)),
        decoration: setInputDecoration(context),
      ),
    );
  }

  InputDecoration setInputDecoration(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColorDark;
    final error = context.select((LoginBloc b) => b.state.email).error;
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
          return null;
      default:
        return null;
    }
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput(this.node);

  final FocusNode node;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) => TextFormField(
        initialValue: state.password.value,
        focusNode: node,
        textInputAction: TextInputAction.done,
        obscureText: state.passwordObscured,
        obscuringCharacter: '*',
        onChanged: (password) =>
            context.read<LoginBloc>().add(LoginPasswordChanged(password)),
        cursorColor: Theme.of(context).primaryColorDark,
        decoration: setInputDecoration(context, state.passwordObscured),
      ),
    );
  }

  InputDecoration setInputDecoration(
      BuildContext context, bool passwordObscured) {
    final primaryColor = Theme.of(context).primaryColorDark;
    final error = context.select((LoginBloc b) => b.state.password).error;
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
          context.read<LoginBloc>().add(LoginPasswordVisibility());
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

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return BlocBuilder<LoginBloc, LoginState>(
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
                return Text('Login');
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
                    context.read<LoginBloc>().add(LoginSubmitted());
                  }
                : null,
          ),
        );
      },
    );
  }

  Color primaryColorSelect(BuildContext context) {
    final primaryColorDark = Theme.of(context).primaryColorDark;
    final isLoading =
        context.select((LoginBloc b) => b.state.status).isSubmissionInProgress;
    if (isLoading) return Colors.transparent;
    return primaryColorDark;
  }
}

class _RegistrationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Text('Not registered? Click here!'),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          textStyle: Theme.of(context).textTheme.button,
        ),
        onPressed: () {
          Navigator.of(context).push(RegistrationPage.route());
        });
  }
}