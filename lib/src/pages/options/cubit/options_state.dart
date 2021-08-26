part of 'options_cubit.dart';

class OptionsState extends Equatable {
  const OptionsState({
    this.position = -1,
    this.personnelIndex = -1,
    this.personnelSelection = const [false, false, false],
    this.personnelSelected = false,
  });

  final int position;
  final int personnelIndex;
  final List<bool> personnelSelection;
  final bool personnelSelected;

  OptionsState copyWith({
    int? position,
    int? personnelIndex,
    List<bool>? personnelSelection,
    bool? personnelSelected,
  }) {
    return OptionsState(
      position: position ?? this.position,
      personnelIndex: personnelIndex ?? this.personnelIndex,
      personnelSelection: personnelSelection ?? this.personnelSelection,
      personnelSelected: personnelSelected ?? this.personnelSelected,
    );
  }

  @override
  List<Object?> get props => [
        position,
        personnelIndex,
        personnelSelection,
        personnelSelected,
      ];

  @override
  String toString() {
    return 'DeliveryOptionsState(position: $position, '
        'personnelIndex: $personnelIndex, '
        'personnelSelection: $personnelSelection, '
        'personnelSelected: $personnelSelected'
        ')';
  }
}
