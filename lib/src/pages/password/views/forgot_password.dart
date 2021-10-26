import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';

class ForgotPasswordPage extends StatelessWidget {
  static Route route() => AppRoutes.generateRoute(
        child: ForgotPasswordPage(),
        fullScreenDialog: true,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.blue.shade50,
      body: BlocProvider(
        create: (_) => SendEmailCubit(
          authRepo: RepositoryProvider.of(context),
          errorHandler: RepositoryProvider.of(context),
        ),
        child: _Form(),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Form> {
  final _emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<SendEmailCubit>().onEmailUnFocused();
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendEmailCubit, SendEmailState>(
      listener: (context, state) async {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pushReplacement(LoginPage.route());
        }
      },
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            alignment: Alignment.center,
            child: Column(
              children: [
                headerWidget(),
                const SizedBox(height: 8.0),
                _EmailInput(_emailFocusNode),
                const SizedBox(height: 24.0),
                const SizedBox(height: 120.0),
                _SubmitButton()
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
      child: Builder(
        builder: (context) {
          final status = context.select((SendEmailCubit c) => c.state.status);
          if (status.isSubmissionSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Check your email and follow the instruction.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forgot Password',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 24),
              Text(
                'Enter your email.',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontWeight: FontWeight.w700),
              )
            ],
          );
        },
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput(this.node);

  final FocusNode node;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SendEmailCubit, SendEmailState, Email>(
      selector: (s) => s.email,
      builder: (context, state) => TextFormField(
        initialValue: state.value,
        focusNode: node,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        cursorColor: Theme.of(context).primaryColorDark,
        onChanged: (email) =>
            context.read<SendEmailCubit>().onEmailChanged(email),
        decoration: setInputDecoration(context),
      ),
    );
  }

  InputDecoration setInputDecoration(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColorDark;
    final error = context.select((SendEmailCubit b) => b.state.email).error;
    return InputDecoration(
      prefixIcon: Icon(Icons.email, color: primaryColor),
      focusColor: primaryColor,
      hintText: 'Email',
      errorText: getError(error),
      hintStyle: Theme.of(context)
          .textTheme
          .caption
          ?.copyWith(fontWeight: FontWeight.w700),
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

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return BlocBuilder<SendEmailCubit, SendEmailState>(
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
                if (state.status.isSubmissionSuccess) {
                  return Text('Back to Login');
                }
                return Text('Submit');
              },
            ),
            style: ElevatedButton.styleFrom(
              textStyle: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(fontWeight: FontWeight.w700),
              padding: EdgeInsets.all(16.0),
              primary: primaryColorSelect(context),
            ),
            onPressed: state.status.isValidated
                ? () {
                    if (state.status.isSubmissionSuccess) {
                      Navigator.of(context).pop();
                    } else {
                      context.read<SendEmailCubit>().onSubmitForgotPassword();
                    }
                    FocusScope.of(context).unfocus();
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
        .select((SendEmailCubit b) => b.state.status)
        .isSubmissionInProgress;
    if (isLoading) return Colors.transparent;
    return primaryColorDark;
  }
}

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: Text('Back to Login'),
        style: ElevatedButton.styleFrom(
          textStyle: Theme.of(context)
              .textTheme
              .button
              ?.copyWith(fontWeight: FontWeight.w700),
          padding: EdgeInsets.all(16.0),
          primary: Theme.of(context).primaryColorDark,
        ),
        onPressed: () =>
            Navigator.of(context).pushReplacement(LoginPage.route()),
      ),
    );
  }
}
