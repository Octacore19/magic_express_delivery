import 'package:magic_express_delivery/src/index.dart';

class DeliveryModel {
  final List<Map<String, dynamic>>? _orderItems;
  final Map<String, dynamic>? _pickUpLocation;
  final Map<String, dynamic>? _destinationLocation;
  final String? _senderName;
  final String? _senderMobile;
  final String? _receiverName;
  final String? _receiverMobile;
  final String? _deliveryNote;
  final int? _orderType;
  final int? _paymentMethod;
  final int? _personnelOption;

  DeliveryModel({
    List<_DeliveryItem>? items,
    Location? pickUpLocation,
    Location? destinationLocation,
    String? senderName,
    String? senderMobile,
    String? receiverName,
    String? receiverMobile,
    String? deliveryNote,
    int? orderType,
    int? paymentMethod,
    int? personnelOption,
  })  : _orderItems = items?.map((e) => _DeliveryItem.toJson(e)).toList(),
        _pickUpLocation = Location.toJson(pickUpLocation),
        _destinationLocation = Location.toJson(destinationLocation),
        _senderName = senderName,
        _senderMobile = senderMobile,
        _receiverName = receiverName,
        _receiverMobile = receiverMobile,
        _deliveryNote = deliveryNote,
        _orderType = orderType,
        _paymentMethod = paymentMethod,
        _personnelOption = personnelOption;

  static Map<String, dynamic> toJson(DeliveryModel model) {
    return {
      'orderItems': model._orderItems,
      'pickup_location': model._pickUpLocation,
      'dropoff_location': model._destinationLocation,
      'sender_name': model._senderName,
      'sender_mobile': model._senderMobile,
      'receiver_name': model._receiverName,
      'receiver_mobile': model._receiverMobile,
      'delivery_note': model._deliveryNote,
      'order_type': model._orderType,
      'payment_method': model._paymentMethod,
      'personnel_option': model._personnelOption,
    };
  }

  @override
  String toString() {
    return 'DeliveryModel(orderItems: $_orderItems, '
        'pickUpLocation: $_pickUpLocation, '
        'destinationLocation: $_destinationLocation, '
        'senderName: $_senderName, '
        'senderMobile: $_senderMobile, '
        'receiverName: $_receiverName, '
        'receiverMobile: $_receiverMobile, '
        'deliveryNote: $_deliveryNote, '
        'orderType: $_orderType, '
        'paymentMethod: $_paymentMethod, '
        'personnelOption: $_personnelOption)';
  }
}

class _DeliveryItem extends Item {
  final String? _item;
  final String? _description;
  final int? _quantity;

  _DeliveryItem({
    String? item,
    String? description,
    int? quantity,
  })  : _item = item,
        _description = description,
        _quantity = quantity,
        super(item, description, quantity);

  static Map<String, dynamic> toJson(_DeliveryItem? item) {
    return {
      'item': item?._item,
      'description': item?._description,
      'quantity': item?._quantity,
    };
  }

  @override
  String toString() {
    return 'DeliveryItem(item: $_item, description: $_description, quantity: $_quantity)';
  }
}
