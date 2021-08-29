part of 'process_delivery_cubit.dart';

class ProcessDeliveryState extends Equatable {
  ProcessDeliveryState({
    this.paymentSelection = const [true, false],
  });

  final List<bool> paymentSelection;

  ProcessDeliveryState copyWith({
    List<bool>? paymentSelection,
  }) {
    return ProcessDeliveryState(
      paymentSelection: paymentSelection ?? this.paymentSelection,
    );
  }

  @override
  List<Object?> get props => [paymentSelection];
}
