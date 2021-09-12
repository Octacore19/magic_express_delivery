part of 'history_bloc.dart';

class HistoryState extends Equatable {
  HistoryState._({
    required this.status,
    required this.history,
    required this.detail,
    required this.message,
  });

  factory HistoryState.initial() {
    return HistoryState._(
      status: Status.initial,
      history: List.empty(),
      detail: HistoryDetail.empty(),
      message: '',
    );
  }

  final Status status;
  final List<History> history;
  final HistoryDetail detail;
  final String message;

  bool get loading => status == Status.loading;
  bool get noRider => detail.rider == OrderUser.empty();

  HistoryState copyWith({
    Status? status,
    List<History>? history,
    HistoryDetail? detail,
    String? message,
  }) {
    return HistoryState._(
      status: status ?? this.status,
      history: history ?? this.history,
      detail: detail ?? this.detail,
      message: message ?? '',
    );
  }

  @override
  List<Object?> get props => [status, history, detail, message];
}
