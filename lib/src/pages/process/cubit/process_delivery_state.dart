part of 'process_delivery_cubit.dart';

class ProcessDeliveryState extends Equatable {
  ProcessDeliveryState({
    this.paymentSelection = const [true, false],
    this.senderName = '',
    this.senderPhone = '',
    this.receiverName = '',
    this.receiverPhone = '',
    this.deliveryNote = '',
    this.paymentType = PaymentType.cash,
    this.personnelType = PersonnelType.unknown,
    this.orderType = OrderType.unknown,
  }) {
    print('Personnel type $personnelType');
  }

  final List<bool> paymentSelection;
  final String senderName;
  final String senderPhone;
  final String receiverName;
  final String receiverPhone;
  final String deliveryNote;
  final PaymentType paymentType;
  final PersonnelType personnelType;
  final OrderType orderType;

  bool get errand => orderType == OrderType.errand;

  bool get delivery => orderType == OrderType.delivery;

  bool get sender => personnelType == PersonnelType.sender;

  bool get receiver => personnelType == PersonnelType.receiver;

  bool get thirdParty => personnelType == PersonnelType.thirdParty;

  bool get senderVisible => sender || thirdParty;

  bool get receiverVisible => receiver || thirdParty;

  bool get _senderButtonActive =>
      sender && senderName.isNotEmpty && senderPhone.isNotEmpty;

  bool get _receiverActive =>
      receiver && receiverName.isNotEmpty && receiverPhone.isNotEmpty;

  bool get _thirdPartyActive =>
      thirdParty &&
      senderName.isNotEmpty &&
      senderPhone.isNotEmpty &&
      receiverName.isNotEmpty &&
      receiverPhone.isNotEmpty;

  bool get buttonActive => _senderButtonActive || _receiverActive || _thirdPartyActive;

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
