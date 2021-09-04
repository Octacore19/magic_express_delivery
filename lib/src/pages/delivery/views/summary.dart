import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:magic_express_delivery/src/utils/currency_converter.dart';
import 'package:repositories/repositories.dart';

class DeliverySummaryDialog extends StatelessWidget {
  void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<DeliveryBloc>(context),
        child: DeliverySummaryDialog(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Summary'),
      actions: [TextButton(onPressed: () {}, child: Text('Proceed'))],
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _PickupDetails(),
          const SizedBox(height: 24),
          _DeliveryDetails(),
          const SizedBox(height: 24),
          _ItemsDetails(),
          const SizedBox(height: 16),
          _DistanceDetails(),
        ],
      ),
    );
  }
}

class _PickupDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<DeliveryBloc, DeliveryState, PlaceDetail>(
      selector: (s) => s.pickupDetail,
      builder: (_, detail) => Text.rich(
        TextSpan(
          text: 'Pickup Address: ',
          style: Theme.of(context).textTheme.bodyText1,
          children: [
            TextSpan(
              text: detail.address,
              style: Theme.of(context).textTheme.bodyText2,
            )
          ],
        ),
      ),
    );
  }
}

class _DeliveryDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<DeliveryBloc, DeliveryState, PlaceDetail>(
      selector: (s) => s.deliveryDetail,
      builder: (_, detail) => Text.rich(
        TextSpan(
          text: 'Delivery Address: ',
          style: Theme.of(context).textTheme.bodyText1,
          children: [
            TextSpan(
              text: detail.address,
              style: Theme.of(context).textTheme.bodyText2,
            )
          ],
        ),
      ),
    );
  }
}

class _ItemsDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryBloc, DeliveryState>(
      builder: (_, state) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'No of items',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  'Total Amount',
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],
            ),
          ),
          const SizedBox(height: 4),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  state.cartItems.length.toString(),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Text(
                  convertToNairaAndKobo(state.totalPrice),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(fontFamily: 'Roboto'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _DistanceDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<DeliveryBloc, DeliveryState, double>(
      selector: (s) => s.distance,
      builder: (_, distance) => Text.rich(
        TextSpan(
          text: 'Distance covered: ',
          style: Theme.of(context).textTheme.bodyText1,
          children: [
            TextSpan(
              text: '${distance.toStringAsFixed(2)} km',
              style: Theme.of(context).textTheme.bodyText2,
            )
          ],
        ),
      ),
    );
  }
}
