import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:magic_express_delivery/src/utils/utils.dart';
import 'package:repositories/repositories.dart';

part 'history_detail_views.dart';

class HistoryDetailPage extends StatelessWidget {
  static Route route(BuildContext context) {
    return AppRoutes.generateRoute(
      child: BlocProvider.value(
        value: BlocProvider.of<HistoryBloc>(context),
        child: HistoryDetailPage(),
      ),
      fullScreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Detail'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<HistoryBloc, HistoryState>(
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
                  _RiderDetailWidget(detail: detail),
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
