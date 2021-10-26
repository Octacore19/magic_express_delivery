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
      emit(state.copyWith(history: history, status: Status.initial));
    });
    _detailSubscription = ridersRepo.detail.listen((detail) {
      emit(state.copyWith(detail: detail, status: Status.initial));
    });
  }

  final RidersRepo _ridersRepo;
  final ErrorHandler _handler;

  late StreamSubscription _orderSubscription;
  late StreamSubscription _detailSubscription;

  void fetchHistoryDetail(String id) async {
    emit(state.copyWith(
      status: Status.loading,
      detail: OrderDetail.empty(),
      task: Task.general,
    ));
    try {
      await _ridersRepo.fetchHistoryDetail(id.toString());
      emit(state.copyWith(status: Status.success));
    } on Exception catch (e) {
      _handler.handleExceptionsWithAction(e, () => fetchHistoryDetail(id));
      emit(state.copyWith(status: Status.error));
    }
  }

  void refreshHistory() async {
    emit(state.copyWith(
      status: Status.loading,
      detail: OrderDetail.empty(),
      task: Task.general,
    ));
    try {
      await _ridersRepo.fetchAllHistory();
      emit(state.copyWith(status: Status.success));
    } on Exception catch (e) {
      _handler.handleExceptionsWithAction(e, refreshHistory);
      emit(state.copyWith(status: Status.error));
    }
  }

  void updatePaymentStatus() async {
    emit(state.copyWith(status: Status.loading, task: Task.payment));
    try {
      final id = state.detail.id.toString();
      await _ridersRepo.updateOrderPaymentStatus(id);
      emit(state.copyWith(status: Status.success));
      _ridersRepo.fetchAllHistory();
      _ridersRepo.fetchHistoryDetail(id);
    } on Exception catch (e) {
      _handler.handleExceptions(e);
      emit(state.copyWith(status: Status.error));
    }
  }

  void updateOrderStatus(OrderStatus status) async {
    emit(state.copyWith(status: Status.loading, task: Task.order));
    try {
      final id = state.detail.id.toString();
      await _ridersRepo.updateOrderStatus(id, status);
      emit(state.copyWith(status: Status.success));
      _ridersRepo.fetchAllHistory();
      _ridersRepo.fetchHistoryDetail(id);
    } on Exception catch (e) {
      _handler.handleExceptions(e);
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
    _detailSubscription.cancel();
    return super.close();
  }
}
