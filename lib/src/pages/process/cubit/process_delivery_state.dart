part of 'process_delivery_cubit.dart';

class ProcessDeliveryState extends Equatable {
  ProcessDeliveryState({
    this.paymentSelection = const [true, false],
    this.senderName = '',
    this.senderPhone = '',
    this.receiverName = '',
    this.receiverPhone = '',
    this.deliveryNote = '',
    this.paymentType = PaymentType.Cash,
    this.deliveryType = DeliveryType.Sender,
    this.taskType = TaskType.Errand,
  });

  final List<bool> paymentSelection;
  final String senderName;
  final String senderPhone;
  final String receiverName;
  final String receiverPhone;
  final String deliveryNote;
  final PaymentType paymentType;
  final DeliveryType deliveryType;
  final TaskType taskType;

  bool get buttonActive =>
      senderName.isNotEmpty &&
      senderPhone.isNotEmpty &&
      receiverName.isNotEmpty &&
      receiverPhone.isNotEmpty;

  bool get errand => taskType == TaskType.Errand;

  bool get delivery => taskType == TaskType.Delivery;

  bool get sender => deliveryType == DeliveryType.Sender;

  bool get receiver => deliveryType == DeliveryType.Receiver;

  bool get thirdParty => deliveryType == DeliveryType.ThirdParty;

  bool get senderVisible => sender || thirdParty;

  bool get receiverVisible => receiver || thirdParty;

  ProcessDeliveryState copyWith({
    List<bool>? paymentSelection,
    String? senderName,
    String? senderPhone,
    String? receiverName,
    String? receiverPhone,
    String? deliveryNote,
    PaymentType? paymentType,
    TaskType? taskType,
    DeliveryType? deliveryType,
  }) {
    return ProcessDeliveryState(
      paymentSelection: paymentSelection ?? this.paymentSelection,
      senderName: senderName ?? this.senderName,
      senderPhone: senderPhone ?? this.senderPhone,
      receiverName: receiverName ?? this.receiverName,
      receiverPhone: receiverPhone ?? this.receiverPhone,
      deliveryNote: deliveryNote ?? this.deliveryNote,
      paymentType: paymentType ?? this.paymentType,
      taskType: taskType ?? this.taskType,
      deliveryType: deliveryType ?? this.deliveryType,
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
        paymentType,
        taskType,
        deliveryType,
      ];
}

enum PaymentType { Card, Cash }
