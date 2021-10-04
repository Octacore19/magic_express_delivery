part of 'rider_home_cubit.dart';

class RiderHomeState extends Equatable {
  RiderHomeState._({
    required this.status,
    required List<Order> history,
    required this.detail,
    required this.message,
    required this.riderAvailable,
    required this.task,
  }) : _history = history;

  factory RiderHomeState.init() {
    return RiderHomeState._(
      status: Status.initial,
      history: List.empty(),
      detail: OrderDetail.empty(),
      message: '',
      riderAvailable: false,
      task: Task.general,
    );
  }

  final Status status;
  final List<Order> _history;
  final OrderDetail detail;
  final String message;
  final Task task;

  final bool riderAvailable;

  bool get buttonActive => !_loading;

  bool get _loading => status == Status.loading;

  bool get success =>
      status == Status.success && (task == Task.payment || task == Task.order);

  bool get loading => _loading && task == Task.general;

  bool get loadingPay => _loading && task == Task.payment;

  bool get loadingOrder => _loading && task == Task.order;

  List<Order> get newOrders {
    return _history
        .where((e) =>
            e.status == OrderStatus.processed ||
            e.status == OrderStatus.assigned ||
            e.status == OrderStatus.transit)
        .toList();
  }

  List<Order> get completedOrders {
    return _history.where((e) => e.status == OrderStatus.delivered).toList();
  }

  bool get noCompleted => completedOrders.isEmpty;

  bool get noActive => newOrders.isEmpty;

  RiderHomeState copyWith({
    Status? status,
    List<Order>? history,
    OrderDetail? detail,
    String? message,
    bool? riderAvailable,
    Task? task,
  }) {
    return RiderHomeState._(
      status: status ?? this.status,
      history: history ?? _history,
      detail: detail ?? this.detail,
      message: message ?? '',
      riderAvailable: riderAvailable ?? this.riderAvailable,
      task: task ?? this.task,
    );
  }

  factory RiderHomeState.fromJson(Map<String, dynamic> json) {
    return RiderHomeState._(
      status: Status.initial,
      history: List.empty(),
      detail: OrderDetail.empty(),
      message: '',
      riderAvailable: json['available'],
      task: Task.general,
    );
  }

  Map<String, dynamic> toJson() {
    return {'available': riderAvailable};
  }

  @override
  List<Object?> get props => [
        status,
        _history,
        detail,
        message,
        riderAvailable,
        task,
      ];
}

enum Task { general, payment, order }
