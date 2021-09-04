part of 'coordinator_cubit.dart';

class CoordinatorState extends Equatable {
  const CoordinatorState({
    this.taskType = TaskType.Errand,
    this.deliveryType = DeliveryType.Sender,
    this.cartItems = const [],
    this.senderName = '',
    this.senderPhone = '',
    this.receiverName = '',
    this.receiverPhone = '',
    this.deliveryNote = '',
    this.types = PaymentType.Cash,
  });

  final TaskType taskType;
  final DeliveryType deliveryType;
  final List<CartItem> cartItems;
  final String senderName;
  final String senderPhone;
  final String receiverName;
  final String receiverPhone;
  final String deliveryNote;
  final PaymentType types;

  bool get errand => taskType == TaskType.Errand;

  bool get delivery => taskType == TaskType.Delivery;

  bool get sender => deliveryType == DeliveryType.Sender;

  bool get receiver => deliveryType == DeliveryType.Receiver;

  bool get thirdParty => deliveryType == DeliveryType.ThirdParty;

  bool get senderVisible => sender || thirdParty;

  bool get receiverVisible => receiver || thirdParty;

  CoordinatorState copyWith({
    TaskType? taskType,
    DeliveryType? deliveryType,
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

enum TaskType { Delivery, Errand }

enum DeliveryType { Sender, Receiver, ThirdParty }

extension TaskTypeExtension on TaskType {
  int get id {
    if (this == TaskType.Errand) {
      return 1;
    } else {
      return 2;
    }
  }

  String get name {
    if (this == TaskType.Errand) {
      return 'Errand';
    } else {
      return 'Delivery';
    }
  }
}

extension DeliveryTypeExtension on DeliveryType {
  int get id {
    switch (this) {
      case DeliveryType.Sender:
        return 1;
      case DeliveryType.Receiver:
        return 2;
      case DeliveryType.ThirdParty:
        return 3;
    }
  }

  String get name {
    switch(this) {
      case DeliveryType.Sender:
        return 'Sender';
      case DeliveryType.Receiver:
        return 'Receiver';
      case DeliveryType.ThirdParty:
        return 'Third-Party';
    }
  }
}
