import 'dart:io';

import 'package:flutter/material.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:magic_express_delivery/src/utils/utils.dart';
import 'package:repositories/repositories.dart';

class ErrorHandler {
  final BuildContext context = AppKeys.navigatorKey.currentContext!;

  void handleExceptions(Exception e) {
    switch (e.runtimeType) {
      case DioError:
        _handleDioError(e as DioError);
        break;
      case RequestFailureException:
        _ErrorDialogBuilder(
          message: (e as RequestFailureException).message ?? 'Unable to fetch request',
        )..show(context);
        break;
      case NoDataException:
        _ErrorDialogBuilder(
          message: 'No data available, try again',
        )..show(context);
        break;
      case NoElementException:
        _ErrorDialogBuilder(
          message: 'No data available, try again',
        )..show(context);
        break;
    }
  }

  void handleExceptionsWithAction(Exception e, VoidCallback onPressed) {
    switch (e.runtimeType) {
      case DioError:
        _handleDioError(e as DioError, onPressed);
        break;
      case RequestFailureException:
        _ErrorDialogBuilder(
          message: (e as RequestFailureException).message ?? 'Unable to fetch request',
          onRetry: onPressed,
        )..show(context);
        break;
      case NoDataException:
        _ErrorDialogBuilder(
          message: 'No data available, try again',
          onRetry: onPressed,
        )..show(context);
        break;
      case NoElementException:
        _ErrorDialogBuilder(
          message: 'No data available, try again',
          onRetry: onPressed,
        )..show(context);
        break;
    }
  }

  void _handleDioError(DioError e, [VoidCallback? onPressed]) {
    switch (e.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        _ErrorDialogBuilder(
          message: 'Connection timed out',
          onRetry: onPressed,
        )..show(context);
        break;
      case DioErrorType.response:
        final code = e.response?.statusCode;
        if (code == 401) {
          final msg = Text('Your session has timed out, please log in again.');
          final snack = SnackBar(content: msg);
          ScaffoldMessenger.of(context).showSnackBar(snack);
          AppKeys.navigatorKey.currentState?.pushAndRemoveUntil(
            LoginPage.route(),
            (route) => false,
          );
        } else if (code == 403) {
          print('no permission');
        } else if (code == 400) {
          final msg = e.response?.data['error'];
          _ErrorDialogBuilder(
            message: msg ?? 'Unexpected error occurred!',
            onRetry: onPressed,
          )..show(context);
        }
        break;
      case DioErrorType.cancel:
        print('Request is cancelled!');
        break;
      case DioErrorType.other:
        switch (e.error.runtimeType) {
          case SocketException:
          case HttpException:
            _ErrorDialogBuilder(
              message: 'Unable to connect to the Internet',
              onRetry: onPressed,
            )..show(context);
            break;
          default:
            final msg = Text('Oops! An unexpected error occurred.');
            final snack = SnackBar(content: msg);
            ScaffoldMessenger.of(context).showSnackBar(snack);
            break;
        }
        break;
    }
  }
}

class _ErrorDialogBuilder extends StatelessWidget {
  _ErrorDialogBuilder({required this.message, this.onRetry});

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
            Image.asset(
              AppImages.ERROR_ICON,
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.1,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('DISMISS'),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      textStyle: Theme.of(context).textTheme.button,
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
                            textStyle: Theme.of(context).textTheme.button,
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
      builder: (_) => _ErrorDialogBuilder(
        message: message,
        onRetry: onRetry,
      ),
    );
  }
}
