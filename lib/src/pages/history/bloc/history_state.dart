part of 'history_bloc.dart';

class HistoryState extends Equatable {
  HistoryState._({
    required this.status,
    required List<Order> history,
    required this.detail,
    required this.message,
  }) : _history = history;

  factory HistoryState.initial() {
    return HistoryState._(
      status: Status.initial,
      history: List.empty(),
      detail: OrderDetail.empty(),
      message: '',
    );
  }

  final Status status;
  final List<Order> _history;
  final OrderDetail detail;
  final String message;

  bool get loading => status == Status.loading;

  bool get noRider => detail.rider == OrderUser.empty();

  bool get noHistory => _history.isEmpty;

  List<Order> get activeOrders {
    return _history
        .where((e) =>
            e.status == OrderStatus.assigned || e.status == OrderStatus.transit)
        .toList();
  }

  List<Order> get inActiveOrders {
    return _history
        .where((e) =>
            e.status == OrderStatus.created ||
            e.status == OrderStatus.processed ||
            e.status == OrderStatus.delivered)
        .toList();
  }

  HistoryState copyWith({
    Status? status,
    List<Order>? history,
    OrderDetail? detail,
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
