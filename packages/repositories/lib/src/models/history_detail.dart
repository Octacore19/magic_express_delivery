import 'package:equatable/equatable.dart';
import 'package:services/services.dart';

class HistoryDetail extends Equatable {
  const HistoryDetail._({
    required this.id,
    required this.user,
    required this.rider,
    required this.orderItems,
    required this.totalAmount,
    required this.pickupAddress,
    required this.dropOffAddress,
    required this.senderName,
    required this.senderPhone,
    required this.receiverPhone,
    required this.receiverName,
    required this.deliveryNote,
    required this.storeName,
    required this.trackingNumber,
    required this.status,
    required this.orderType,
    required this.paymentMethod,
    required this.personnelOption,
    required this.paymentStatus,
    required this.paymentVerified,
    required this.paidAt,
    required this.deliveredAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HistoryDetail.empty() {
    return HistoryDetail._(
      id: -1,
      user: OrderUser.empty(),
      rider: OrderUser.empty(),
      orderItems: List.empty(),
      totalAmount: 0,
      pickupAddress: '',
      dropOffAddress: '',
      senderName: '',
      senderPhone: '',
      receiverPhone: '',
      receiverName: '',
      deliveryNote: '',
      storeName: '',
      trackingNumber: '',
      status: '',
      orderType: '',
      paymentMethod: '',
      personnelOption: '',
      paymentStatus: '',
      paymentVerified: false,
      paidAt: '',
      deliveredAt: '',
      createdAt: '',
      updatedAt: '',
    );
  }

  factory HistoryDetail.fromResponse(HistoryDetailResponse response) {
    return HistoryDetail._(
      id: response.id ?? -1,
      user: OrderUser.fromResponse(response.user),
      rider: OrderUser.fromResponse(response.rider),
      orderItems:
          response.orderItems?.map((e) => OrderItem.fromResponse(e)).toList() ??
              [],
      totalAmount: double.tryParse(response.totalAmount ?? '') ?? 0,
      pickupAddress: response.pickupAddress ?? '',
      dropOffAddress: response.dropOffAddress ?? '',
      senderName: response.senderName ?? '',
      senderPhone: response.senderPhone ?? '',
      receiverPhone: response.receiverPhone ?? '',
      receiverName: response.receiverName ?? '',
      deliveryNote: response.deliveryNote ?? '',
      storeName: response.storeName ?? '',
      trackingNumber: response.trackingNumber ?? '',
      status: response.status ?? 'Unknown',
      orderType: response.orderType ?? '',
      paymentMethod: response.paymentMethod ?? '',
      personnelOption: response.personnelOption ?? '',
      paymentStatus: response.paymentStatus ?? '',
      paymentVerified: response.paymentVerified ?? false,
      paidAt: response.paidAt ?? '',
      deliveredAt: response.deliveredAt ?? '',
      createdAt: response.createdAt ?? '',
      updatedAt: response.updatedAt ?? '',
    );
  }

  final int id;
  final OrderUser user;
  final OrderUser rider;
  final List<OrderItem> orderItems;
  final double totalAmount;
  final String pickupAddress;
  final String dropOffAddress;
  final String senderName;
  final String senderPhone;
  final String receiverName;
  final String receiverPhone;
  final String deliveryNote;
  final String storeName;
  final String trackingNumber;
  final String status;
  final String orderType;
  final String paymentMethod;
  final String personnelOption;
  final String paymentStatus;
  final bool paymentVerified;
  final String paidAt;
  final String deliveredAt;
  final String createdAt;
  final String updatedAt;

  @override
  List<Object?> get props => [
        id,
        user,
        rider,
        orderItems,
        totalAmount,
        pickupAddress,
        dropOffAddress,
        senderName,
        senderPhone,
        receiverName,
        receiverPhone,
        deliveryNote,
        storeName,
        trackingNumber,
        status,
        orderType,
        paymentMethod,
        personnelOption,
        paymentStatus,
        paymentVerified,
        paidAt,
        deliveredAt,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() {
    return '$runtimeType('
        'id: $id, '
        'user: $user, '
        'rider: $rider, '
        'orderItems: $orderItems, '
        'totalAmount: $totalAmount, '
        'pickupAddress: $pickupAddress, '
        'dropOffAddress: $dropOffAddress, '
        'senderName: $senderName, '
        'senderPhone: $senderPhone, '
        'receiverName: $receiverName, '
        'receiverPhone: $receiverPhone, '
        'deliveryNote: $deliveryNote, '
        'storeName: $storeName, '
        'trackingNumber: $trackingNumber, '
        'status: $status, '
        'orderType: $orderType, '
        'paymentMethod: $paymentMethod, '
        'personnelOption: $personnelOption, '
        'paymentStatus: $paymentStatus, '
        'paymentVerified: $paymentVerified, '
        'paidAt: $paidAt, '
        'deliveredAt: $deliveredAt, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt'
        ')';
  }
}

class OrderUser extends Equatable {
  const OrderUser._({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory OrderUser.empty() {
    return OrderUser._(
      id: -1,
      firstName: '',
      lastName: '',
      email: '',
    );
  }

  factory OrderUser.fromResponse(UserResponse? response) {
    if (response == null) {
      return OrderUser.empty();
    }
    return OrderUser._(
      id: response.id ?? -1,
      firstName: response.firstName ?? '',
      lastName: response.lastName ?? '',
      email: response.email ?? '',
    );
  }

  final int id;
  final String firstName;
  final String lastName;
  final String email;

  @override
  List<Object?> get props => [id, firstName, lastName, email];

  @override
  String toString() {
    return '$runtimeType('
        'id: $id, '
        'firstName: $firstName, '
        'lastName: $lastName, '
        'email: $email'
        ')';
  }
}

class OrderItem extends Equatable {
  const OrderItem._({
    required this.id,
    required this.itemName,
    required this.quantity,
    required this.description,
    required this.price,
  });

  factory OrderItem.empty() {
    return OrderItem._(
      id: -1,
      itemName: '',
      quantity: 0,
      description: '',
      price: 0,
    );
  }

  factory OrderItem.fromResponse(OrderItemResponse response) {
    return OrderItem._(
      id: response.id ?? -1,
      itemName: response.itemName ?? '',
      quantity: response.quantity ?? 0,
      description: response.description ?? '',
      price: double.tryParse(response.price ?? '') ?? 0,
    );
  }

  final int id;
  final String itemName;
  final int quantity;
  final String description;
  final double price;

  @override
  List<Object?> get props => [id, itemName, quantity, description, price];

  @override
  String toString() {
    return '$runtimeType('
        'id: $id, '
        'itemName: $itemName, '
        'quantity: $quantity, '
        'description: $description, '
        'price: $price'
        ')';
  }
}
