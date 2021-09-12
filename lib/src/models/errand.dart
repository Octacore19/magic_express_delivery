import 'package:magic_express_delivery/src/models/models.dart';
import 'package:repositories/repositories.dart';

class ErrandOrder extends Equatable {
  const ErrandOrder._({
    required this.orderItems,
    required this.storeName,
    required this.storeLocation,
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

  factory ErrandOrder({
    List<CartItem>? orderItems,
    String? storeName,
    Location? storeLocation,
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
    return ErrandOrder._(
      orderItems: orderItems ?? [],
      storeName: storeName ?? '',
      storeLocation: storeLocation ?? Location.empty(),
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

  factory ErrandOrder.empty() {
    return ErrandOrder._(
      orderItems: [],
      storeName: '',
      storeLocation: Location.empty(),
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
  final String storeName;
  final Location storeLocation;
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

  bool get empty => this == ErrandOrder.empty();

  bool get notEmpty => this != ErrandOrder.empty();

  Map<String, dynamic> toJson() {
    return {
      'store_name': storeName,
      'orderItems': orderItems.map((e) => e.toJson()).toList(),
      'pickup_location': storeLocation.toJson(),
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

  ErrandOrder copyWith({
    List<CartItem>? orderItems,
    String? storeName,
    Location? storeLocation,
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
    return ErrandOrder._(
      orderItems: orderItems ?? this.orderItems,
      storeName: storeName ?? this.storeName,
      storeLocation: storeLocation ?? this.storeLocation,
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
        storeName,
        storeLocation,
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
