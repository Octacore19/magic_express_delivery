part of 'history_bloc.dart';

class HistoryState extends Equatable {
  HistoryState._({
    required this.status,
    required List<History> history,
    required this.detail,
    required this.message,
  }) : _history = history;

  factory HistoryState.initial() {
    return HistoryState._(
      status: Status.initial,
      history: List.empty(),
      detail: HistoryDetail.empty(),
      message: '',
    );
  }

  final Status status;
  final List<History> _history;
  final HistoryDetail detail;
  final String message;

  bool get loading => status == Status.loading;

  bool get noRider => detail.rider == OrderUser.empty();

  bool get noHistory => _history.isEmpty;

  List<History> get activeOrders {
    return _history
        .where((e) =>
            e.status == OrderStatus.assigned || e.status == OrderStatus.transit)
        .toList();
  }

  List<History> get inActiveOrders {
    return _history
        .where((e) =>
    e.status != OrderStatus.assigned || e.status != OrderStatus.transit)
        .toList();
  }

  HistoryState copyWith({
    Status? status,
    List<History>? history,
    HistoryDetail? detail,
    String? message,
  }) {
    return HistoryState._(
      status: status ?? this.status,
      history: history ?? this._history,
      detail: detail ?? this.detail,
      message: message ?? '',
    );
  }

  @override
  List<Object?> get props => [status, _history, detail, message];
}
