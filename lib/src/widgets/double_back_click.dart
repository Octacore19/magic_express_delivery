import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DoubleBackToCloseWidget extends StatefulWidget {
  final Widget child; // Make Sure this child has a Scaffold widget as parent.

  const DoubleBackToCloseWidget({
    required this.child,
  });

  @override
  _DoubleBackToCloseWidgetState createState() =>
      _DoubleBackToCloseWidgetState();
}

class _DoubleBackToCloseWidgetState extends State<DoubleBackToCloseWidget> {
  int _lastTimeBackButtonWasTapped = 0;
  static const exitTimeInMillis = 2000;

  bool get _isAndroid => Theme.of(context).platform == TargetPlatform.android;

  @override
  Widget build(BuildContext context) {
    if (_isAndroid) {
      return WillPopScope(
        onWillPop: _handleWillPop,
        child: widget.child,
      );
    } else {
      return widget.child;
    }
  }

  Future<bool> _handleWillPop() async {
    final _currentTime = DateTime.now().millisecondsSinceEpoch;

    if (_currentTime - _lastTimeBackButtonWasTapped < exitTimeInMillis) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      SystemNavigator.pop(animated: true);
      return false;
    } else {
      _lastTimeBackButtonWasTapped = DateTime.now().millisecondsSinceEpoch;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(_getExitSnackBar());
      return false;
    }
  }

  SnackBar _getExitSnackBar() {
    return SnackBar(
      content: Text('Press BACK again to exit!'),
      duration: const Duration(milliseconds: exitTimeInMillis),
      behavior: SnackBarBehavior.floating,
    );
  }
}
