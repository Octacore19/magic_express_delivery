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
          _SuccessDialogBuilder(
            message: "A reset link has been sent to your email. Check your email!",
          )..show(context);
        }
      },
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                headerWidget(),
                const SizedBox(height: 8.0),
                _EmailInput(_emailFocusNode),
                const SizedBox(height: 24.0),
                const SizedBox(height: 120.0),
                _SubmitButton(),
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
      child: Column(
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
    final state = context.select((SendEmailCubit b) => b.state);
    return ElevatedButton(
      child: Builder(
        builder: (_) {
          if (state.loading) {
            return SizedBox.fromSize(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
              size: Size(22.0, 22.0),
            );
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
      onPressed: state.loading || state.status.isValidated
          ? () {
              FocusScope.of(context).unfocus();
              context.read<SendEmailCubit>().onSubmitForgotPassword();
            }
          : null,
    );
  }

  Color primaryColorSelect(BuildContext context) {
    final primaryColorDark = Theme.of(context).primaryColorDark;
    final isLoading = context.select((SendEmailCubit b) => b.state.loading);
    if (isLoading) return Colors.transparent;
    return primaryColorDark;
  }
}

class _SuccessDialogBuilder extends StatelessWidget {
  _SuccessDialogBuilder({required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        side: BorderSide(),
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      contentPadding: EdgeInsets.zero,
      content: ConstrainedBox(
        constraints:
            BoxConstraints(minWidth: MediaQuery.of(context).size.width * 0.3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 24.0),
            Icon(Icons.check, size: 48),
            const SizedBox(height: 24.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    message,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(LoginPage.route());
                    },
                    child: Text('DISMISS'),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      textStyle: Theme.of(context)
                          .textTheme
                          .button
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Visibility(
                  visible: onRetry != null,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            if (onRetry != null) {
                              onRetry!();
                            }
                          },
                          child: Text('RETRY'),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            textStyle: Theme.of(context)
                                .textTheme
                                .button
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _SuccessDialogBuilder(
        message: message,
        onRetry: onRetry,
      ),
    );
  }
}
