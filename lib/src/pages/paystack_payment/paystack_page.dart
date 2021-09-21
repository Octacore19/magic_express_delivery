import 'package:flutter/material.dart';
import 'package:flutter_paystack_client/flutter_paystack_client.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaystackPage extends StatelessWidget {
  const PaystackPage({
    required this.reference,
    required this.amount,
  });

  final String reference;
  final double amount;

  static Route route({
    required String reference,
    required double amount,
  }) {
    return AppRoutes.generateRoute(
      child: PaystackPage(
        reference: reference,
        amount: amount,
      ),
      fullScreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.blue.shade50,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(48),
          child: Column(
            children: [
              Image(
                image: AssetImage(AppImages.ATM_CARD),
              ),
              const SizedBox(height: 96),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 16,
                  ),
                ),
                onPressed: () => _processPayment(context),
                child: Text('Proceed to pay with Paystack'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _processPayment(BuildContext context) async {
    final email = context.read<AppBloc>().state.user.email;
    final c = Charge()
      ..email = email
      ..reference = reference
      ..amount = (amount * 100).toInt();
    final res = await PaystackClient.checkout(context, charge: c);
    if (res.status) {
      print('Charge was successful. Ref: ${res.reference}');
      Navigator.of(context).push(FindRiderPage.route());
    } else {
      print('Failed: ${res.message}');
    }
  }
}
