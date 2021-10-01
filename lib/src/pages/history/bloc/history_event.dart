part of 'history_bloc.dart';

class HistoryEvent extends Equatable {
  HistoryEvent(this.actions, [this.args]);

  final HistoryActions actions;
  final Object? args;

  @override
  List<Object?> get props => [args, actions];
}

enum HistoryActions {
  onRefreshHistoryList,
  fetchHistoryDetail,
  getHistoryList,
}
