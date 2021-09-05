part of 'process_delivery_cubit.dart';

class ProcessDeliveryState extends Equatable {
  ProcessDeliveryState({
    this.paymentSelection = const [true, false],
    this.senderName = '',
    this.senderPhone = '',
    this.receiverName = '',
    this.receiverPhone = '',
    this.deliveryNote = '',
    this.paymentType = PaymentType.unknown,
    this.personnelType = PersonnelType.unknown,
    this.orderType = OrderType.unknown,
  });

  final List<bool> paymentSelection;
  final String senderName;
  final String senderPhone;
  final String receiverName;
  final String receiverPhone;
  final String deliveryNote;
  final PaymentType paymentType;
  final PersonnelType personnelType;
  final OrderType orderType;

  bool get buttonActive =>
      senderName.isNotEmpty &&
      senderPhone.isNotEmpty &&
      receiverName.isNotEmpty &&
      receiverPhone.isNotEmpty;

  bool get errand => orderType == OrderType.errand;

  bool get delivery => orderType == OrderType.delivery;

  bool get sender => personnelType == PersonnelType.sender;

  bool get receiver => personnelType == PersonnelType.receiver;

  bool get thirdParty => personnelType == PersonnelType.thirdParty;

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
    OrderType? orderType,
    PersonnelType? personnelType,
  }) {
    return ProcessDeliveryState(
      paymentSelection: paymentSelection ?? this.paymentSelection,
      senderName: senderName ?? this.senderName,
      senderPhone: senderPhone ?? this.senderPhone,
      receiverName: receiverName ?? this.receiverName,
      receiverPhone: receiverPhone ?? this.receiverPhone,
      deliveryNote: deliveryNote ?? this.deliveryNote,
      paymentType: paymentType ?? this.paymentType,
      orderType: orderType ?? this.orderType,
      personnelType: personnelType ?? this.personnelType,
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
        orderType,
        personnelType,
      ];
}
