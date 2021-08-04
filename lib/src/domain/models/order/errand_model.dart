/*
import 'package:magic_express_delivery/src/index.dart';

class ErrandModel {
  final List<Map<String, dynamic>>? _orderItems;
  final Map<String, dynamic>? _pickUpLocation;
  final Map<String, dynamic>? _destinationLocation;
  final String? _senderName;
  final String? _senderMobile;
  final String? _receiverName;
  final String? _receiverMobile;
  final String? _deliveryNote;
  final double? _totalCartPrices;
  final int? _orderType;
  final int? _paymentMethod;
  final int? _personnelOption;

  ErrandModel({
    List<_ErrandItems>? item,
    Location? pickUpLocation,
    Location? destinationLocation,
    String? senderName,
    String? senderMobile,
    String? receiverName,
    String? receiverMobile,
    String? deliveryNote,
    double? totalCartPrice,
    int? orderType,
    int? paymentMethod,
    int? personnelOption,
  })  : _orderItems = item?.map((e) => _ErrandItems.toJson(e)).toList(),
        _pickUpLocation = Location.toJson(pickUpLocation),
        _destinationLocation = Location.toJson(destinationLocation),
        _senderName = senderName,
        _senderMobile = senderMobile,
        _receiverName = receiverName,
        _receiverMobile = receiverMobile,
        _deliveryNote = deliveryNote,
        _totalCartPrices = totalCartPrice,
        _orderType = orderType,
        _paymentMethod = paymentMethod,
        _personnelOption = personnelOption;

  static Map<String, dynamic> toJson(ErrandModel model) {
    return {
      'orderItems': model._orderItems,
      'pickup_location': model._pickUpLocation,
      'dropoff_location': model._destinationLocation,
      'sender_name': model._senderName,
      'sender_mobile': model._senderMobile,
      'receiver_name': model._receiverName,
      'receiver_mobile': model._receiverMobile,
      'delivery_note': model._deliveryNote,
      'total_cart_price': model._totalCartPrices,
      'order_type': model._orderType,
      'payment_method': model._paymentMethod,
      'personnel_option': model._personnelOption,
    };
  }

  @override
  String toString() {
    return 'ErrandModel(orderItems: $_orderItems, '
        'pickUpLocation: $_pickUpLocation, '
        'destinationLocation: $_destinationLocation, '
        'senderName: $_senderName, '
        'senderMobile: $_senderMobile, '
        'receiverName: $_receiverName, '
        'receiverMobile: $_receiverMobile, '
        'deliveryNote: $_deliveryNote, '
        'totalCartPrice: $_totalCartPrices, '
        'orderType: $_orderType, '
        'paymentMethod: $_paymentMethod, '
        'personnelOption: $_personnelOption)';
  }
}

class _ErrandItems extends Item {
  final String? _item;
  final String? _description;
  final int? _quantity;
  final double? _unitPrice;
  final double? _totalPrice;

  _ErrandItems({
    String? item,
    String? description,
    int? quantity,
    double? unitPrice,
    double? totalPrice,
  })  : _item = item,
        _description = description,
        _quantity = quantity,
        _unitPrice = unitPrice,
        _totalPrice = totalPrice,
        super(item, description, quantity);

  static Map<String, dynamic> toJson(_ErrandItems? item) {
    return {
      'item': item?._item,
      'description': item?._description,
      'quantity': item?._quantity,
      'unit_price': item?._unitPrice,
      'total_price': item?._totalPrice,
    };
  }

  @override
  String toString() {
    return 'ErrandItem(item: $_item, description: $_description, quantity: $_quantity, unitPrice: $_unitPrice, totalPrice: $_totalPrice)';
  }
}
*/
