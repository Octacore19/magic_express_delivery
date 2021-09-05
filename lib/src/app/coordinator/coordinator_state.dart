part of 'coordinator_cubit.dart';

class CoordinatorState extends Equatable {
  const CoordinatorState({
    this.taskType = OrderType.errand,
    this.deliveryType = PersonnelType.sender,
    this.cartItems = const [],
    this.senderName = '',
    this.senderPhone = '',
    this.receiverName = '',
    this.receiverPhone = '',
    this.deliveryNote = '',
    this.types = PaymentType.cash,
  });

  final OrderType taskType;
  final PersonnelType deliveryType;
  final List<CartItem> cartItems;
  final String senderName;
  final String senderPhone;
  final String receiverName;
  final String receiverPhone;
  final String deliveryNote;
  final PaymentType types;

  bool get errand => taskType == OrderType.errand;

  bool get delivery => taskType == OrderType.delivery;

  bool get sender => deliveryType == PersonnelType.sender;

  bool get receiver => deliveryType == PersonnelType.receiver;

  bool get thirdParty => deliveryType == PersonnelType.thirdParty;

  bool get senderVisible => sender || thirdParty;

  bool get receiverVisible => receiver || thirdParty;

  CoordinatorState copyWith({
    OrderType? taskType,
    PersonnelType? deliveryType,
    List<CartItem>? cartItems,
    String? senderName,
    String? senderPhone,
    String? receiverName,
    String? receiverPhone,
    String? deliveryNote,
    PaymentType? types,
  }) {
    return CoordinatorState(
      taskType: taskType ?? this.taskType,
      deliveryType: deliveryType ?? this.deliveryType,
      cartItems: cartItems ?? this.cartItems,
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
        taskType,
        deliveryType,
        cartItems,
        senderName,
        senderPhone,
        receiverPhone,
        receiverName,
        deliveryNote,
        types,
      ];
}
