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
              showDialog(
                context: context,
                builder: (context) {
                  Future.delayed(Duration(seconds: 5)).then((value){
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  });
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 16.0),
                        Text(
                          'Payment Confirmed',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16.0),
                        Image(
                          image: AssetImage(AppImages.DELIVERY_IMAGE),
                          height: MediaQuery.of(context).size.width * 0.25,
                          width: MediaQuery.of(context).size.width * 0.25,
                        ),
                        const SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Your payment has been confirmed. We'll notify you when a rider has been assigned to your order.",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
          builder: (_, state) {
            return Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(48),
              child: Column(
                children: [
                  Image(
                    image: AssetImage(AppImages.ATM_CARD),
                    height: MediaQuery.of(context).size.height * .35,
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                  const SizedBox(height: 72),
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
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.blue.shade900),
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
