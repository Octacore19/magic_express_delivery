import 'package:magic_express_delivery/src/models/models.dart';
import 'package:repositories/repositories.dart';

class DeliveryOrder extends Equatable {
  const DeliveryOrder._({
    required this.orderItems,
    required this.pickupLocation,
    required this.destinationLocation,
    required this.totalPrice,
    required this.senderName,
    required this.senderPhone,
    required this.receiverName,
    required this.receiverPhone,
    required this.deliveryNote,
    required this.orderType,
    required this.paymentType,
    required this.personnelType,
  });

  factory DeliveryOrder({
    List<CartItem>? orderItems,
    Location? pickupLocation,
    Location? destinationLocation,
    double? totalPrice,
    String? senderName,
    String? senderPhone,
    String? receiverName,
    String? receiverPhone,
    String? deliveryNote,
    OrderType? orderType,
    PaymentType? paymentType,
    PersonnelType? personnelType,
  }) {
    return DeliveryOrder._(
      orderItems: orderItems ?? [],
      pickupLocation: pickupLocation ?? Location.empty(),
      destinationLocation: destinationLocation ?? Location.empty(),
      totalPrice: totalPrice ?? 0,
      senderName: senderName ?? '',
      senderPhone: senderPhone ?? '',
      receiverName: receiverName ?? '',
      receiverPhone: receiverPhone ?? '',
      deliveryNote: deliveryNote ?? '',
      orderType: orderType ?? OrderType.unknown,
      paymentType: paymentType ?? PaymentType.cash,
      personnelType: personnelType ?? PersonnelType.unknown,
    );
  }

  factory DeliveryOrder.empty() {
    return DeliveryOrder._(
      orderItems: [],
      pickupLocation: Location.empty(),
      destinationLocation: Location.empty(),
      totalPrice: 0,
      senderName: '',
      senderPhone: '',
      receiverName: '',
      receiverPhone: '',
      deliveryNote: '',
      orderType: OrderType.unknown,
      paymentType: PaymentType.cash,
      personnelType: PersonnelType.unknown,
    );
  }

  final List<CartItem> orderItems;
  final Location pickupLocation;
  final Location destinationLocation;
  final double totalPrice;
  final String senderName;
  final String senderPhone;
  final String receiverName;
  final String receiverPhone;
  final String deliveryNote;
  final OrderType orderType;
  final PaymentType paymentType;
  final PersonnelType personnelType;

  bool get empty => this == DeliveryOrder.empty();

  bool get notEmpty => this != DeliveryOrder.empty();

  Map<String, dynamic> toJson() {
    return {
      'orderItems': orderItems.map((e) => e.toJson()).toList(),
      'pickup_location': pickupLocation.toJson(),
      'dropoff_location': destinationLocation.toJson(),
      'total_price': totalPrice,
      'sender_name': senderName,
      'sender_mobile': senderPhone,
      'receiver_name': receiverName,
      'receiver_mobile': receiverPhone,
      'delivery_note': deliveryNote,
      'order_type': orderType.id,
      'payment_method': paymentType.id,
      'personnel_option': personnelType.id,
    };
  }

  DeliveryOrder copyWith({
    List<CartItem>? orderItems,
    Location? pickupLocation,
    Location? destinationLocation,
    double? totalPrice,
    String? senderName,
    String? senderPhone,
    String? receiverPhone,
    String? receiverName,
    String? deliveryNote,
    OrderType? orderType,
    PaymentType? paymentType,
    PersonnelType? personnelType,
  }) {
    return DeliveryOrder._(
      orderItems: orderItems ?? this.orderItems,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      destinationLocation: destinationLocation ?? this.destinationLocation,
      totalPrice: totalPrice ?? this.totalPrice,
      senderName: senderName ?? this.senderName,
      senderPhone: senderPhone ?? this.senderPhone,
      receiverName: receiverName ?? this.receiverName,
      receiverPhone: receiverPhone ?? this.receiverPhone,
      deliveryNote: deliveryNote ?? this.deliveryNote,
      orderType: orderType ?? this.orderType,
      paymentType: paymentType ?? this.paymentType,
      personnelType: personnelType ?? this.personnelType,
    );
  }

  @override
  List<Object?> get props => [
        orderItems,
        pickupLocation,
        destinationLocation,
        totalPrice,
        senderName,
        senderPhone,
        receiverName,
        receiverPhone,
        deliveryNote,
        orderType,
        paymentType,
        personnelType
      ];
}
