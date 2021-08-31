import 'package:flutter/material.dart';

class ErrandSummaryDialog extends StatelessWidget {
  void show(BuildContext context) {
    showDialog(context: context, builder: (_) => ErrandSummaryDialog());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog();
  }
}
