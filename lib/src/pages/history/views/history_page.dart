import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/models/models.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:magic_express_delivery/src/utils/currency_converter.dart';
import 'package:repositories/repositories.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => HistoryBloc(
        ordersRepo: RepositoryProvider.of(context),
        errorHandler: RepositoryProvider.of(context),
      ),
      child: LayoutBuilder(
        builder: (context, constraint) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Order History',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(width: 24),
                  BlocSelector<HistoryBloc, HistoryState, Status>(
                    selector: (s) => s.status,
                    builder: (_, status) {
                      if (status == Status.loading) {
                        return SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator.adaptive(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.blue.shade900),
                          ),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  )
                ],
              ),
              Expanded(
                child: RefreshIndicator(
                  displacement: 120,
                  onRefresh: () =>
                      context.read<HistoryBloc>().refreshHistoryList(),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: h,
                      child: BlocBuilder<HistoryBloc, HistoryState>(
                        builder: (_, state) {
                          if (state.noHistory) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                children: [
                                  const SizedBox(height: 24),
                                  Icon(
                                    Icons.warning_amber_rounded,
                                    size: 96,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No data currently available to display',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  TextButton(
                                    onPressed: () {
                                      final action =
                                          HistoryActions.onRefreshHistoryList;
                                      final event = HistoryEvent(action);
                                      context.read<HistoryBloc>().add(event);
                                    },
                                    child: Text(
                                      'Click to refresh page',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              buildList(
                                context,
                                state.sortedList,
                                'Active orders',
                              ),
                              state.activeOrders.isNotEmpty
                                  ? SizedBox(height: 24)
                                  : SizedBox.shrink(),
                              buildList(
                                context,
                                state.inActiveOrders,
                                'Non-Active orders',
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, List<Order> history, String header) {
    if (history.isEmpty) return SizedBox.shrink();
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(6),
            ),
            padding: EdgeInsets.all(8),
            child: Text(
              header,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              key: ObjectKey(history),
              itemCount: history.length,
              itemBuilder: (_, index) {
                final d = history[index];
                return buildItem(context, d);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, Order d) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        key: ObjectKey(d),
        color: Colors.blue[50]?.withOpacity(1),
        shadowColor: Colors.blue[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          isThreeLine: true,
          contentPadding: EdgeInsets.all(16),
          onTap: () {
            final action = HistoryActions.fetchHistoryDetail;
            final event = HistoryEvent(action, d);
            context.read<HistoryBloc>().add(event);
            Navigator.of(context).push(HistoryDetailPage.route(context));
          },
          title: Column(
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
                      d.startAddress,
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
                      d.endAddress,
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
          subtitle: Padding(
            padding: EdgeInsets.only(top: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  convertToNairaAndKobo(d.amount),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontFamily: 'Roboto'),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: _getStatusColor(d.status), width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    d.status.value,
                    style: Theme.of(context).textTheme.caption?.copyWith(
                        color: _getStatusColor(d.status),
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.created:
        return Colors.grey.shade700;
      case OrderStatus.processed:
      case OrderStatus.assigned:
        return Colors.orange;
      case OrderStatus.transit:
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.unknown:
        return Colors.red;
    }
  }
}
