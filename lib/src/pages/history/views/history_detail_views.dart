part of 'history_detail.dart';

class _LocationWidget extends StatelessWidget {
  const _LocationWidget({
    required this.detail,
    Key? key,
  }) : super(key: key);

  final HistoryDetail detail;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[50]?.withOpacity(1),
      shadowColor: Colors.blue[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.arrow_upward_rounded,
                  color: Colors.green,
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    detail.pickupAddress,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.arrow_downward_rounded,
                  color: Colors.red,
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    detail.dropOffAddress,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PersonnelDetailHeader extends StatelessWidget {
  const _PersonnelDetailHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            'PERSONNEL DETAIL',
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

class _RecipientWidget extends StatelessWidget {
  const _RecipientWidget({
    required this.detail,
    Key? key,
  }) : super(key: key);

  final HistoryDetail detail;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: Colors.blue[50]?.withOpacity(1),
        shadowColor: Colors.blue[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
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
                            text: detail.senderName,
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        text: 'Sender Phone: ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontWeight: FontWeight.w700),
                        children: [
                          TextSpan(
                            text: detail.senderPhone,
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                visible: detail.senderName.isNotEmpty,
              ),
              Visibility(
                visible: detail.receiverName.isNotEmpty,
                child: Padding(
                  padding: EdgeInsets.only(top: 16),
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
                              text: detail.receiverName,
                              style: Theme.of(context).textTheme.bodyText2,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text.rich(
                        TextSpan(
                          text: 'Receiver Phone: ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontWeight: FontWeight.w700),
                          children: [
                            TextSpan(
                              text: detail.receiverPhone,
                              style: Theme.of(context).textTheme.bodyText2,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderItemsHeader extends StatelessWidget {
  const _OrderItemsHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            'ORDER ITEMS',
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

class _CartItemsWidget extends StatelessWidget {
  const _CartItemsWidget({
    required this.detail,
    Key? key,
  }) : super(key: key);

  final HistoryDetail detail;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Card(
        color: Colors.blue[50]?.withOpacity(1),
        shadowColor: Colors.blue[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListView.builder(
          itemCount: detail.orderItems.length,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            final item = detail.orderItems[index];
            return ListTile(
              leading: Text(
                '${index + 1}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              dense: true,
              title: Text(
                item.itemName,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              subtitle: item.description.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        item.description,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    )
                  : null,
              trailing: Text(
                convertToNairaAndKobo(item.price),
                style: Theme.of(context).textTheme.caption?.copyWith(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SummaryWidget extends StatelessWidget {
  const _SummaryWidget({
    required this.detail,
    Key? key,
  }) : super(key: key);

  final HistoryDetail detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'TOTAL AMOUNT',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    convertToNairaAndKobo(detail.totalAmount),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontFamily: 'Roboto'),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: _paymentStatusColor(detail.paymentStatus),
                ),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                detail.paymentStatus,
                style: Theme.of(context).textTheme.caption?.copyWith(
                    color: _paymentStatusColor(detail.paymentStatus)),
              ),
            ),
            const SizedBox(width: 24),
            Builder(
              builder: (_) {
                if (detail.paidAt.isEmpty) return SizedBox.shrink();
                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'PAYMENT DATE AND TIME',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        detail.paidAt,
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
        Visibility(
          child: Padding(
            padding: EdgeInsets.only(top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'DELIVERY NOTE',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  detail.deliveryNote,
                  style: Theme.of(context).textTheme.bodyText2,
                )
              ],
            ),
          ),
          visible: detail.deliveryNote.isNotEmpty,
        ),
        Visibility(
          child: Padding(
            padding: EdgeInsets.only(top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'STORE NAME',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  detail.storeName,
                  style: Theme.of(context).textTheme.bodyText2,
                )
              ],
            ),
          ),
          visible: detail.storeName.isNotEmpty,
        ),
        Padding(
          padding: EdgeInsets.only(top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ORDER DATE AND TIME',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                detail.createdAt,
                style: Theme.of(context).textTheme.bodyText2,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'DELIVERY STATUS',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    detail.deliveredAt.isNotEmpty
                        ? 'Delivered'
                        : 'Not Delivered',
                    style: Theme.of(context).textTheme.bodyText2,
                  )
                ],
              ),
              Visibility(
                visible: detail.deliveredAt.isNotEmpty,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'DELIVERY DATE AND TIME',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      detail.deliveredAt,
                      style: Theme.of(context).textTheme.bodyText2,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Color _paymentStatusColor(String value) {
    if (value.toLowerCase() == 'not paid') {
      return Colors.red;
    }
    return Colors.green;
  }
}
