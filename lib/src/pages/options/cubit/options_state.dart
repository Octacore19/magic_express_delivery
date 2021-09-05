part of 'options_cubit.dart';

class OptionsState extends Equatable {
  const OptionsState._({
    required this.orderType,
    required this.personnelType,
    required this.personnelSelection,
  });

  factory OptionsState.initial(OrderType orderType) {
    return OptionsState._(
      orderType: orderType,
      personnelType: PersonnelType.unknown,
      personnelSelection: [false, false, false]
    );
  }

  final OrderType orderType;
  final PersonnelType personnelType;
  final List<bool> personnelSelection;

  bool get errand => orderType == OrderType.errand;

  bool get personnelSelected => personnelSelection.contains(true);

  bool get noPersonnelSelected => !personnelSelected;

  OptionsState copyWith({
    PersonnelType? personnelType,
    List<bool>? personnelSelection,
  }) {
    return OptionsState._(
      orderType: this.orderType,
      personnelType: personnelType ?? this.personnelType,
      personnelSelection: personnelSelection ?? this.personnelSelection,
    );
  }

  @override
  List<Object?> get props => [
        orderType,
        personnelType,
        personnelSelection,
      ];

  @override
  String toString() {
    return 'DeliveryOptionsState(position: $orderType, '
        'deliveryType: $personnelType, '
        'personnelSelection: $personnelSelection'
        ')';
  }
}
