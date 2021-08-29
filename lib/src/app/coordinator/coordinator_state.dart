part of 'coordinator_cubit.dart';

class CoordinatorState extends Equatable {
  const CoordinatorState({
    this.taskType = TaskType.Errand,
    this.deliveryType = DeliveryType.Sender,
    this.cartItems = const [],
  });

  final TaskType taskType;
  final DeliveryType deliveryType;
  final List<CartItem> cartItems;

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
  }) {
    return CoordinatorState(
      taskType: taskType ?? this.taskType,
      deliveryType: deliveryType ?? this.deliveryType,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  @override
  List<Object?> get props => [taskType, deliveryType, cartItems];
}

enum TaskType { Delivery, Errand }

enum DeliveryType { Sender, Receiver, ThirdParty }
