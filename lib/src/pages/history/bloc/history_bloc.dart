import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/models/models.dart';
import 'package:repositories/repositories.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc({
    required OrdersRepo ordersRepo,
    required ErrorHandler errorHandler,
  })  : _ordersRepo = ordersRepo,
        _handler = errorHandler,
        super(HistoryState.initial()) {
    _historySubscription = _ordersRepo.history.listen((history) {
      final action = HistoryActions.getHistoryList;
      final event = HistoryEvent(action, history);
      add(event);
    });
  }

  final OrdersRepo _ordersRepo;
  final ErrorHandler _handler;

  late StreamSubscription _historySubscription;

  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) async* {
    switch (event.actions) {
      case HistoryActions.onRefreshHistoryList:
        yield* _mapOnRefreshHistoryList(event, state);
        break;
      case HistoryActions.fetchHistoryDetail:
        yield* _mapFetchHistoryDetail(event, state);
        break;
      case HistoryActions.getHistoryList:
        List<History> args = event.args as List<History>;
        yield state.copyWith(history: args);
        break;
      case HistoryActions.refreshHistoryList:
        yield* _mapRefreshHistoryList(event, state);
        break;
    }
  }

  Stream<HistoryState> _mapFetchHistoryDetail(
    HistoryEvent event,
    HistoryState state,
  ) async* {
    yield state.copyWith(status: Status.loading, detail: HistoryDetail.empty());
    try {
      History arg = event.args as History;
      final res = await _ordersRepo.fetchHistoryDetail(arg.id.toString());
      yield state.copyWith(status: Status.success, detail: res);
    } on Exception catch (e) {
      _handler.handleExceptionsWithAction(e, () => add(event));
      yield state.copyWith(status: Status.error);
    }
  }

  Stream<HistoryState> _mapOnRefreshHistoryList(
    HistoryEvent event,
    HistoryState state,
  ) async* {
    yield state.copyWith(status: Status.loading, detail: HistoryDetail.empty());
    try {
      await _ordersRepo.fetchAllHistory();
      yield state.copyWith(status: Status.success);
    } on Exception catch (e) {
      _handler.handleExceptionsWithAction(e, () => add(event));
      yield state.copyWith(status: Status.error);
    }
  }

  Stream<HistoryState> _mapRefreshHistoryList(
    HistoryEvent event,
    HistoryState state,
  ) async* {
    try {
      await _ordersRepo.fetchAllHistory();
      yield state.copyWith(status: Status.success);
    } on Exception catch (e) {
      _handler.handleExceptions(e);
      yield state.copyWith(status: Status.error);
    }
  }

  Future<void> refreshHistoryList() async {
    try {
      await _ordersRepo.fetchAllHistory();
    } on Exception catch (e) {
      _handler.handleExceptions(e);
    }
  }

  @override
  Future<void> close() {
    _historySubscription.cancel();
    return super.close();
  }
}
