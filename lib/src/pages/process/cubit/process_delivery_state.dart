part of 'process_delivery_cubit.dart';

class ProcessDeliveryState extends Equatable {
  ProcessDeliveryState({
    this.paymentSelection = const [true, false],
    this.senderName = '',
    this.senderPhone = '',
    this.receiverName = '',
    this.receiverPhone = '',
    this.deliveryNote = '',
    this.types = PaymentTypes.Cash,
  });

  final List<bool> paymentSelection;
  final String senderName;
  final String senderPhone;
  final String receiverName;
  final String receiverPhone;
  final String deliveryNote;
  final PaymentTypes types;

  bool get buttonActive =>
      senderName.isNotEmpty &&
      senderPhone.isNotEmpty &&
      receiverName.isNotEmpty &&
      receiverPhone.isNotEmpty;

  ProcessDeliveryState copyWith({
    List<bool>? paymentSelection,
    String? senderName,
    String? senderPhone,
    String? receiverName,
    String? receiverPhone,
    String? deliveryNote,
    PaymentTypes? types,
  }) {
    return ProcessDeliveryState(
      paymentSelection: paymentSelection ?? this.paymentSelection,
      senderName: senderName ?? this.senderName,
      senderPhone: senderPhone ?? this.senderPhone,
      receiverName: receiverName ?? this.receiverName,
      receiverPhone: receiverPhone ?? this.receiverPhone,
      deliveryNote: deliveryNote ?? this.deliveryNote,
      types: types ?? this.types,
    );
  }

  @override
  List<Object?> get props => [
        paymentSelection,
        senderName,
        senderPhone,
        receiverPhone,
        receiverName,
        deliveryNote,
        types,
      ];
}

enum PaymentTypes { Card, Cash }
