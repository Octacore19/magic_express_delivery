import 'package:flutter/material.dart';
import 'package:flutter_paystack_client/flutter_paystack_client.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/pages/paystack_payment/paystack_cubit.dart';

class PaystackPage extends StatelessWidget {
  const PaystackPage({
    required this.orderId,
    required this.reference,
    required this.amount,
  });

  final String orderId;
  final String reference;
  final double amount;

  static Route route({
    required String orderId,
    required String reference,
    required double amount,
  }) {
    return AppRoutes.generateRouteBuilder(
      builder: (context) => BlocProvider(
        create: (context) => PaystackCubit(
          ordersRepo: RepositoryProvider.of(context),
          reference: reference,
          orderId: orderId,
          errorHandler: RepositoryProvider.of(context),
        ),
        child: PaystackPage(
          orderId: orderId,
          reference: reference,
          amount: amount,
        ),
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
        child: BlocConsumer<PaystackCubit, PaystackState>(
          listener: (_, state) {
            if (state.success) {
              Navigator.of(context).push(FindRiderPage.route());
            }
          },
          builder: (_, state) {
            return Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(48),
              child: Column(
                children: [
                  Image(image: AssetImage(AppImages.ATM_CARD)),
                  const SizedBox(height: 96),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 16,
                        ),
                      ),
                      onPressed:
                      state.loading ? null : () => _processPayment(context),
                      child: Builder(
                        builder: (_) {
                          if (state.loading) {
                            return SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator.adaptive(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade900),
                              ),
                            );
                          }
                          return Text('Proceed to pay with Paystack');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
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
      context.read<PaystackCubit>().verifyPayment();
    } else {
      print('Failed: ${res.message}');
    }
  }
}
