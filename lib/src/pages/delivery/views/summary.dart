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
      scrollable: true,
      title: Text('Delivery Summary'),
      titleTextStyle: Theme.of(context)
          .textTheme
          .headline6
          ?.copyWith(fontWeight: FontWeight.w700),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Text('Cancel'),
          style: TextButton.styleFrom(
            textStyle: Theme.of(context)
                .textTheme
                .button
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        TextButton(
          onPressed: () {
            final action = DeliveryAction.OnOrderSubmitted;
            final event = DeliveryEvent(action);
            context.read<DeliveryBloc>().add(event);
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Text('Place order'),
          style: TextButton.styleFrom(
              textStyle: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(fontWeight: FontWeight.w700)),
        )
      ],
      contentPadding: EdgeInsets.all(24),
      content: BlocBuilder<DeliveryBloc, DeliveryState>(
        builder: (_, state) => Column(
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
            const SizedBox(height: 24),
            _TotalAmountDetails(),
            const SizedBox(height: 24),
            _SenderDetails(),
            Visibility(child: SizedBox(height: 24), visible: state.thirdParty),
            _ReceiverDetails(),
          ],
        ),
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
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(fontWeight: FontWeight.w700),
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
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(fontWeight: FontWeight.w700),
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
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  'Total Amount in Cart',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontWeight: FontWeight.w700),
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
                  state.totalQuantity.toString(),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Text(
                  convertToNairaAndKobo(state.totalCartPrice),
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
    return BlocBuilder<DeliveryBloc, DeliveryState>(
      builder: (_, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            TextSpan(
              text: 'Distance covered: ',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontWeight: FontWeight.w700),
              children: [
                TextSpan(
                  text: '${state.estimatedDistance.text}',
                  style: Theme.of(context).textTheme.bodyText2,
                )
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text.rich(
            TextSpan(
              text: 'Estimated Time: ',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontWeight: FontWeight.w700),
              children: [
                TextSpan(
                  text: '${state.estimatedDuration.text}',
                  style: Theme.of(context).textTheme.bodyText2,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _TotalAmountDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryBloc, DeliveryState>(
      builder: (_, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: 'Delivery cost: ',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontWeight: FontWeight.w700),
              children: [
                TextSpan(
                  text: convertToNairaAndKobo(state.deliveryAmount),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(fontFamily: 'Roboto'),
                )
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text.rich(
            TextSpan(
              text: 'Total cost: ',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontWeight: FontWeight.w700),
              children: [
                TextSpan(
                  text: convertToNairaAndKobo(state.totalAmount),
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

class _SenderDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryBloc, DeliveryState>(
      builder: (_, state) => Visibility(
        visible: state.sender || state.thirdParty,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: 'Sender Name: ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontWeight: FontWeight.w700),
                children: [
                  TextSpan(
                    text: state.deliveryOrder.senderName,
                    style: Theme.of(context).textTheme.bodyText2,
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text.rich(
              TextSpan(
                text: 'Sender Phone: ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontWeight: FontWeight.w700),
                children: [
                  TextSpan(
                    text: state.deliveryOrder.senderPhone,
                    style: Theme.of(context).textTheme.bodyText2,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ReceiverDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryBloc, DeliveryState>(
      builder: (_, state) => Visibility(
        visible: state.receiver || state.thirdParty,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: 'Receiver Name: ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontWeight: FontWeight.w700),
                children: [
                  TextSpan(
                    text: state.deliveryOrder.receiverName,
                    style: Theme.of(context).textTheme.bodyText2,
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text.rich(
              TextSpan(
                text: 'Receiver Phone: ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontWeight: FontWeight.w700),
                children: [
                  TextSpan(
                    text: state.deliveryOrder.receiverPhone,
                    style: Theme.of(context).textTheme.bodyText2,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
