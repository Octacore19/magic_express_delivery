import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ChangePasswordPage extends StatelessWidget {
  static Route route() => AppRoutes.generateRoute(
        child: ChangePasswordPage(),
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
        create: (_) => ChangePasswordCubit(
          errorHandler: RepositoryProvider.of(context),
          miscRepo: RepositoryProvider.of(context),
        ),
        child: _Form(),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final _oldPasswordNode = FocusNode();
  final _newPasswordNode = FocusNode();
  final _confirmPasswordNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _oldPasswordNode.addListener(() {
      context.read<ChangePasswordCubit>().onOldPasswordUnfocused();
    });

    _newPasswordNode.addListener(() {
      context.read<ChangePasswordCubit>().onNewPasswordUnfocused();
    });

    _confirmPasswordNode.addListener(() {
      context.read<ChangePasswordCubit>().onConfirmPasswordUnfocused();
    });
  }

  @override
  void dispose() {
    _oldPasswordNode.dispose();
    _newPasswordNode.dispose();
    _confirmPasswordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          _SuccessDialogBuilder(
            message: "Your password has been successfully changed!",
          )..show(context);
        }
      },
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 16),
          headerWidget(),
          const SizedBox(height: 32),
          _OldPasswordInput(_oldPasswordNode, _newPasswordNode),
          const SizedBox(height: 16),
          _NewPasswordInput(_newPasswordNode, _confirmPasswordNode),
          const SizedBox(height: 16),
          _ConfirmPasswordInput(_confirmPasswordNode),
          const SizedBox(height: 48),
          _SubmitButton(),
        ],
      ),
    );
  }

  Widget headerWidget() {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        'Change Password',
        style: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _OldPasswordInput extends StatelessWidget {
  const _OldPasswordInput(this.node, [this.next]);

  final FocusNode node;
  final FocusNode? next;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      builder: (context, state) => TextFormField(
        initialValue: state.oldPassword.value,
        focusNode: node,
        textInputAction: TextInputAction.next,
        obscureText: state.oldPasswordObscured,
        obscuringCharacter: '*',
        onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(next),
        onChanged: (password) {
          context.read<ChangePasswordCubit>().onOldPasswordChanged(password);
        },
        cursorColor: Theme.of(context).primaryColorDark,
        decoration: setInputDecoration(context, state.oldPasswordObscured),
      ),
    );
  }

  InputDecoration setInputDecoration(
      BuildContext context, bool passwordObscured) {
    final primaryColor = Theme.of(context).primaryColorDark;
    final error =
        context.select((ChangePasswordCubit b) => b.state.oldPassword).error;
    return InputDecoration(
      prefixIcon: Icon(Icons.password, color: primaryColor),
      hintText: 'Current Password',
      focusColor: primaryColor,
      errorText: getError(error),
      hintStyle: Theme.of(context)
          .textTheme
          .caption
          ?.copyWith(fontWeight: FontWeight.w700),
      suffixIcon: InkWell(
        child: Icon(
          passwordObscured ? MdiIcons.eye : MdiIcons.eyeOff,
          color: primaryColor,
        ),
        onTap: () {
          context.read<ChangePasswordCubit>().toggleOldPasswordObscure();
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

class _NewPasswordInput extends StatelessWidget {
  const _NewPasswordInput(this.node, [this.next]);

  final FocusNode node;
  final FocusNode? next;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      builder: (context, state) => TextFormField(
        initialValue: state.newPassword.value,
        focusNode: node,
        textInputAction: TextInputAction.next,
        obscureText: state.newPasswordObscured,
        obscuringCharacter: '*',
        onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(next),
        onChanged: (password) {
          context.read<ChangePasswordCubit>().onNewPasswordChanged(password);
        },
        cursorColor: Theme.of(context).primaryColorDark,
        decoration: setInputDecoration(context, state.newPasswordObscured),
      ),
    );
  }

  InputDecoration setInputDecoration(
      BuildContext context, bool passwordObscured) {
    final primaryColor = Theme.of(context).primaryColorDark;
    final error =
        context.select((ChangePasswordCubit b) => b.state.newPassword).error;
    return InputDecoration(
      prefixIcon: Icon(Icons.password, color: primaryColor),
      hintText: 'New Password',
      focusColor: primaryColor,
      errorText: getError(error),
      hintStyle: Theme.of(context)
          .textTheme
          .caption
          ?.copyWith(fontWeight: FontWeight.w700),
      suffixIcon: InkWell(
        child: Icon(
          passwordObscured ? MdiIcons.eye : MdiIcons.eyeOff,
          color: primaryColor,
        ),
        onTap: () {
          context.read<ChangePasswordCubit>().toggleNewPasswordObscure();
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
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      builder: (context, state) => TextFormField(
        initialValue: state.confirmNew.value,
        focusNode: node,
        textInputAction: TextInputAction.done,
        obscureText: state.confirmPasswordObscured,
        obscuringCharacter: '*',
        onChanged: (password) {
          context
              .read<ChangePasswordCubit>()
              .onConfirmPasswordChanged(password);
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
        context.select((ChangePasswordCubit b) => b.state.confirmNew).error;
    return InputDecoration(
      prefixIcon: Icon(Icons.password, color: primaryColor),
      hintText: 'Confirm New Password',
      focusColor: primaryColor,
      errorText: getError(error),
      hintStyle: Theme.of(context)
          .textTheme
          .caption
          ?.copyWith(fontWeight: FontWeight.w700),
      suffixIcon: InkWell(
        child: Icon(
          passwordObscured ? MdiIcons.eye : MdiIcons.eyeOff,
          color: primaryColor,
        ),
        onTap: () {
          context.read<ChangePasswordCubit>().toggleConfirmPasswordObscure();
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

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      buildWhen: (p, c) => p.status != c.status,
      builder: (context, state) {
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
              return Text('Change Password');
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
                  FocusScope.of(context).unfocus();
                  context.read<ChangePasswordCubit>().onChangePassword();
                }
              : null,
        );
      },
    );
  }

  Color primaryColorSelect(BuildContext context) {
    final primaryColorDark = Theme.of(context).primaryColorDark;
    final isLoading =
        context.select((ChangePasswordCubit b) => b.state.loading);
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
                      Navigator.of(context).popUntil((route) => route.isFirst);
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
