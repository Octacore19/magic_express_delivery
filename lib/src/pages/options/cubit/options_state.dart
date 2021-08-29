part of 'options_cubit.dart';

class OptionsState extends Equatable {
  const OptionsState({
    this.taskType = TaskType.Errand,
    this.deliveryType = DeliveryType.Sender,
    this.personnelSelection = const [false, false, false],
  });

  final TaskType taskType;
  final DeliveryType deliveryType;
  final List<bool> personnelSelection;

  bool get personnelSelected => personnelSelection.contains(true);

  OptionsState copyWith({
    TaskType? taskType,
    DeliveryType? deliveryType,
    List<bool>? personnelSelection,
  }) {
    return OptionsState(
      taskType: taskType ?? this.taskType,
      deliveryType: deliveryType ?? this.deliveryType,
      personnelSelection: personnelSelection ?? this.personnelSelection,
    );
  }

  @override
  List<Object?> get props => [
        taskType,
        deliveryType,
        personnelSelection,
      ];

  @override
  String toString() {
    return 'DeliveryOptionsState(position: $taskType, '
        'deliveryType: $deliveryType, '
        'personnelSelection: $personnelSelection'
        ')';
  }
}
