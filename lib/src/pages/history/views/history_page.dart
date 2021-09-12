import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:magic_express_delivery/src/utils/currency_converter.dart';
import 'package:repositories/repositories.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryBloc(
        ordersRepo: RepositoryProvider.of(context),
        errorHandler: RepositoryProvider.of(context),
      ),
      child: Builder(
        builder: (context) => RefreshIndicator(
          displacement: 120,
          onRefresh: () => context.read<HistoryBloc>().refreshHistoryList(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Order History',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: BlocSelector<HistoryBloc, HistoryState, List<History>>(
                    selector: (s) => s.history,
                    builder: (_, history) => ListView.builder(
                      itemCount: history.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        final d = history[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Card(
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
                                              .subtitle2,
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
                                              .subtitle2,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              subtitle: Padding(
                                padding: EdgeInsets.only(top: 24),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          color: _getStatusColor(d.status)
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(16))
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      child: Text(
                                        d.status,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            ?.copyWith(color: _getStatusColor(d.status)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String value) {
    return Colors.orange;
  }
}
