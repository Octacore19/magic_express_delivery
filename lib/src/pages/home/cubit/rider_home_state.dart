part of 'rider_home_cubit.dart';

class RiderHomeState extends Equatable {
  RiderHomeState._({
    required this.status,
    required List<History> history,
    required this.detail,
    required this.message,
    required this.riderAvailable,
  }) : _history = history;

  factory RiderHomeState.init() {
    return RiderHomeState._(
      status: Status.initial,
      history: List.empty(),
      detail: HistoryDetail.empty(),
      message: '',
      riderAvailable: false,
    );
  }

  final Status status;
  final List<History> _history;
  final HistoryDetail detail;
  final String message;

  final bool riderAvailable;

  bool get loading => status == Status.loading;

  bool get noHistory => _history.isEmpty;

  List<History> get newOrders {
    return _history
        .where((e) =>
            e.status == OrderStatus.processed ||
            e.status == OrderStatus.assigned ||
            e.status == OrderStatus.transit)
        .toList();
  }

  List<History> get completedOrders {
    return _history.where((e) => e.status == OrderStatus.delivered).toList();
  }

  RiderHomeState copyWith({
    Status? status,
    List<History>? history,
    HistoryDetail? detail,
    String? message,
    bool? riderAvailable,
  }) {
    return RiderHomeState._(
      status: status ?? this.status,
      history: history ?? _history,
      detail: detail ?? this.detail,
      message: message ?? '',
      riderAvailable: riderAvailable ?? this.riderAvailable,
    );
  }

  factory RiderHomeState.fromJson(Map<String, dynamic> json) {
    return RiderHomeState._(
      status: Status.initial,
      history: List.empty(),
      detail: HistoryDetail.empty(),
      message: '',
      riderAvailable: json['available'],
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
      ];
}
