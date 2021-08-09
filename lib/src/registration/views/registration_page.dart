import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/registration/registration.dart';
import 'package:magic_express_delivery/src/registration/views/registration_views.dart';
import 'package:quiver/async.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage();

  static Route route() => AppRoutes.buildRoute(RegistrationPage());

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
      listener: (context, state) {
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
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }
          });
          showDialog(
            context: context,
            builder: (_context) {
              return AlertDialog(
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Icon(Icons.check_circle_outline, size: 48.0),
                      const SizedBox(height: 16.0),
                      Text(
                        'Registration Successful! Kindly check your email for a verification link',
                        style: Theme.of(context).textTheme.headline6,
                      )
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0)
                ),
              );
            },
          );
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              headerWidget(),
              SizedBox(height: 16.0),
              FirstNameInput(_firstNameNode),
              SizedBox(height: 16.0),
              LastNameInput(_lastNameNode),
              SizedBox(height: 16.0),
              EmailInput(_emailNode),
              SizedBox(height: 16.0),
              PhoneNumberInput(_phoneNumberNode),
              SizedBox(height: 16.0),
              PasswordInput(_passwordNode, _confirmPasswordNode),
              SizedBox(height: 16.0),
              ConfirmPasswordInput(_confirmPasswordNode),
              SizedBox(height: 32.0),
              CreateButton(),
            ],
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
