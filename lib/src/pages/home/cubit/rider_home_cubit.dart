import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/models/models.dart';
import 'package:repositories/repositories.dart';

part 'rider_home_state.dart';

class RiderHomeCubit extends Cubit<RiderHomeState> {
  RiderHomeCubit({
    required RidersRepo ridersRepo,
    required ErrorHandler errorHandler,
  })  : _ridersRepo = ridersRepo,
        _handler = errorHandler,
        super(RiderHomeState.init()) {
    _orderSubscription = ridersRepo.history.listen((history) {
      emit(state.copyWith(history: history));
    });
  }

  final RidersRepo _ridersRepo;
  final ErrorHandler _handler;

  late StreamSubscription _orderSubscription;

  void fetchHistoryDetail(Order order) async {
    emit(state.copyWith(status: Status.loading, detail: OrderDetail.empty()));
    try {
      final res = await _ridersRepo.fetchHistoryDetail(order.id.toString());
      emit(state.copyWith(status: Status.success, detail: res));
    } on Exception catch (e) {
      _handler.handleExceptionsWithAction(e, () => fetchHistoryDetail(order));
      emit(state.copyWith(status: Status.error));
    }
  }

  void refreshHistory() async {
    emit(state.copyWith(status: Status.loading, detail: OrderDetail.empty()));
    try {
      await _ridersRepo.fetchAllHistory();
      emit(state.copyWith(status: Status.success));
    } on Exception catch (e) {
      _handler.handleExceptionsWithAction(e, refreshHistory);
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> refreshHistoryList() async {
    try {
      await _ridersRepo.fetchAllHistory();
    } on Exception catch (e) {
      _handler.handleExceptions(e);
    }
  }

  @override
  Future<void> close() {
    _orderSubscription.cancel();
    return super.close();
  }
}
