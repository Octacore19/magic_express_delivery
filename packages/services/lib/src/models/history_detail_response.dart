class HistoryDetailResponse {
  const HistoryDetailResponse._({
    required this.id,
    required this.user,
    required this.rider,
    required this.orderItems,
    required this.totalAmount,
    required this.pickupAddress,
    required this.dropOffAddress,
    required this.senderName,
    required this.senderPhone,
    required this.receiverName,
    required this.receiverPhone,
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

  factory HistoryDetailResponse.fromJson(Map<String, dynamic> json) {
    return HistoryDetailResponse._(
      id: json['id'],
      user: UserResponse.fromJson(json['user']),
      rider: UserResponse.fromJson(json['rider']),
      orderItems: (json['order_items'] as List)
          .map((e) => OrderItemResponse.fromJson(e))
          .toList(),
      totalAmount: json['total_amount'],
      pickupAddress: json['pickup_address'],
      dropOffAddress: json['dropoff_address'],
      senderName: json['sender_name'],
      senderPhone: json['sender_mobile'],
      receiverName: json['receiver_name'],
      receiverPhone: json['receiver_mobile'],
      deliveryNote: json['delivery_note'],
      storeName: json['store_name'],
      trackingNumber: json['tracking_number'],
      status: json['order_status'],
      orderType: json['order_type'],
      paymentMethod: json['payment_method'],
      personnelOption: json['personnel_option'],
      paymentStatus: json['payment_status'],
      paymentVerified: json['payment_verified'],
      paidAt: json['paid_at'],
      deliveredAt: json['delivered_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  final int? id;
  final UserResponse? user;
  final UserResponse? rider;
  final List<OrderItemResponse>? orderItems;
  final String? totalAmount;
  final String? pickupAddress;
  final String? dropOffAddress;
  final String? senderName;
  final String? senderPhone;
  final String? receiverName;
  final String? receiverPhone;
  final String? deliveryNote;
  final String? storeName;
  final String? trackingNumber;
  final String? status;
  final String? orderType;
  final String? paymentMethod;
  final String? personnelOption;
  final String? paymentStatus;
  final bool? paymentVerified;
  final String? paidAt;
  final String? deliveredAt;
  final String? createdAt;
  final String? updatedAt;

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

class UserResponse {
  const UserResponse._({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  });

  static UserResponse? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return UserResponse._(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
    );
  }

  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;

  @override
  String toString() {
    return '$runtimeType('
        'id: $id, '
        'firstName: $firstName, '
        'lastName: $lastName, '
        'phoneNumber: $phoneNumber, '
        'email: $email'
        ')';
  }
}

class OrderItemResponse {
  const OrderItemResponse._({
    required this.id,
    required this.itemName,
    required this.quantity,
    required this.description,
    required this.price,
  });

  factory OrderItemResponse.fromJson(Map<String, dynamic> json) {
    return OrderItemResponse._(
      id: json['id'],
      itemName: json['item'],
      quantity: json['quantity'],
      description: json['description'],
      price: json['price'],
    );
  }

  final int? id;
  final String? itemName;
  final int? quantity;
  final String? description;
  final String? price;

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
