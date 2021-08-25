import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/registration/registration.dart';
import 'package:magic_express_delivery/src/registration/views/registration_views.dart';
import 'package:quiver/async.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage();

  static Route route() => AppRoutes.generateRoute(RegistrationPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (_) => RegistrationBloc(
          authRepo: RepositoryProvider.of(context),
        ),
        child: _RegistrationForm(),
      ),
    );
  }
}

class _RegistrationForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<_RegistrationForm> {
  final _firstNameNode = FocusNode();
  final _lastNameNode = FocusNode();
  final _emailNode = FocusNode();
  final _phoneNumberNode = FocusNode();
  final _passwordNode = FocusNode();
  final _confirmPasswordNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _firstNameNode.addListener(() {
      if (!_firstNameNode.hasFocus) {
        final event = RegistrationEvent(
          action: RegistrationEvents.FirstNameUnfocused,
        );
        context.read<RegistrationBloc>().add(event);
      }
    });

    _lastNameNode.addListener(() {
      if (!_lastNameNode.hasFocus) {
        final event = RegistrationEvent(
          action: RegistrationEvents.LastNameUnfocused,
        );
        context.read<RegistrationBloc>().add(event);
      }
    });

    _emailNode.addListener(() {
      if (!_emailNode.hasFocus) {
        final event = RegistrationEvent(
          action: RegistrationEvents.EmailUnfocused,
        );
        context.read<RegistrationBloc>().add(event);
      }
    });

    _phoneNumberNode.addListener(() {
      if (!_phoneNumberNode.hasFocus) {
        final event = RegistrationEvent(
          action: RegistrationEvents.PhoneNumberUnfocused,
        );
        context.read<RegistrationBloc>().add(event);
      }
    });

    _passwordNode.addListener(() {
      final event = RegistrationEvent(
        action: RegistrationEvents.PasswordUnfocused,
      );
      context.read<RegistrationBloc>().add(event);
    });

    _confirmPasswordNode.addListener(() {
      final event = RegistrationEvent(
        action: RegistrationEvents.ConfirmPasswordUnfocused,
      );
      context.read<RegistrationBloc>().add(event);
    });
  }

  @override
  void dispose() {
    _firstNameNode.dispose();
    _lastNameNode.dispose();
    _emailNode.dispose();
    _phoneNumberNode.dispose();
    _passwordNode.dispose();
    _confirmPasswordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) async {
        if (state.status.isSubmissionFailure) {
          String msg =
              state.message.isEmpty ? 'Registration failure' : state.message;
          SnackBar snack = SnackBar(content: Text(msg));
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snack);
        } else if (state.status.isSubmissionSuccess) {
          CountdownTimer(Duration(seconds: 3), Duration(seconds: 1))
              .listen((event) {
            if (event.elapsed.inSeconds == 3) {
              Navigator.of(context, rootNavigator: true).pop();
            }
          });
          await showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Icon(Icons.check_circle_outline, size: 48.0),
                      const SizedBox(height: 16.0),
                      Text(
                        state.message,
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
          Navigator.of(context).pop();
        }
      },
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              children: [
                headerWidget(),
                SizedBox(height: 24),
                FirstNameInput(_firstNameNode),
                SizedBox(height: 24),
                LastNameInput(_lastNameNode),
                SizedBox(height: 24),
                EmailInput(_emailNode),
                SizedBox(height: 24),
                PhoneNumberInput(_phoneNumberNode),
                SizedBox(height: 24),
                PasswordInput(_passwordNode, _confirmPasswordNode),
                SizedBox(height: 24),
                ConfirmPasswordInput(_confirmPasswordNode),
                SizedBox(height: 72),
                CreateButton(),
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
      child: Text(
        'Create account',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
