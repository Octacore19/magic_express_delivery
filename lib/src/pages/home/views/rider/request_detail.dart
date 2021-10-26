import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:magic_express_delivery/src/utils/utils.dart';
import 'package:quiver/async.dart';
import 'package:repositories/repositories.dart';

part 'request_detail_views.dart';

class RequestDetail extends StatelessWidget {
  static Route route(BuildContext context) {
    return AppRoutes.generateRoute(
      child: BlocProvider.value(
        value: BlocProvider.of<RiderHomeCubit>(context),
        child: RequestDetail(),
      ),
      fullScreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Request Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<RiderHomeCubit, RiderHomeState>(
          listener: (_, state) {
            if (state.success && state.task == Task.payment) {
              showDialog(
                context: context,
                builder: (context) {
                  CountdownTimer(Duration(seconds: 3), Duration(seconds: 1))
                      .listen((event) async {
                    if (event.elapsed.inSeconds == 3) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                  });
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle_outline, size: 48.0),
                        const SizedBox(height: 16.0),
                        Text(
                          'Order updated successfully',
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  );
                },
              );
            }
            if (state.success && state.task == Task.order) {
              showDialog(
                context: context,
                builder: (context) {
                  CountdownTimer(Duration(seconds: 3), Duration(seconds: 1))
                      .listen((event) async {
                    if (event.elapsed.inSeconds == 3) {
                      Navigator.of(context, rootNavigator: true)
                          .pushAndRemoveUntil(
                              DashboardPage.route(), (route) => false);
                    }
                  });
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle_outline, size: 48.0),
                        const SizedBox(height: 16.0),
                        Text(
                          'Order updated successfully',
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  );
                },
              );
            }
          },
          builder: (_, state) {
            final detail = state.detail;
            if (state.loading) {
              return Column(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: CircularProgressIndicator.adaptive(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.blue.shade900),
                      ),
                    ),
                  ),
                  Expanded(child: Container())
                ],
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _LocationWidget(detail: detail),
                  const SizedBox(height: 24),
                  _PersonnelDetailHeader(),
                  const SizedBox(height: 16),
                  _RecipientWidget(detail: detail),
                  const SizedBox(height: 24),
                  _OrderItemsHeader(),
                  const SizedBox(height: 16),
                  _CartItemsWidget(detail: detail),
                  const SizedBox(height: 24),
                  _SummaryWidget(detail: detail),
                  Builder(
                    builder: (_) {
                      final d = state.detail;
                      if (d.paymentMethod.toLowerCase() == 'pay on delivery' &&
                          d.paymentStatus.toLowerCase() == 'not paid' &&
                          d.status == OrderStatus.transit) {
                        return _RiderOptionsButton(
                          title: 'Confirm Payment',
                          loading: state.loadingPay,
                          onPressed: () {
                            context
                                .read<RiderHomeCubit>()
                                .updatePaymentStatus();
                          },
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                  Builder(
                    builder: (_) {
                      final d = state.detail;
                      if (d.status == OrderStatus.assigned) {
                        return _RiderOptionsButton(
                          title: 'Confirm Pickup',
                          loading: state.loadingOrder,
                          onPressed: () {
                            context
                                .read<RiderHomeCubit>()
                                .updateOrderStatus(OrderStatus.transit);
                          },
                        );
                      } else if (d.status == OrderStatus.transit) {
                        return _RiderOptionsButton(
                          title: 'Confirm Delivery',
                          loading: state.loadingOrder,
                          onPressed: () {
                            context
                                .read<RiderHomeCubit>()
                                .updateOrderStatus(OrderStatus.delivered);
                          },
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
