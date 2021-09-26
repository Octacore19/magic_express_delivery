enum OrderStatus {
  created,
  processed,
  assigned,
  transit,
  delivered,
  unknown
}

extension OrderStatusExt on OrderStatus {
  static OrderStatus setStatus(String? value) {
    switch (value?.toLowerCase()) {
      case 'created':
        return OrderStatus.created;
      case 'processed':
        return OrderStatus.processed;
      case 'assigned':
        return OrderStatus.assigned;
      case 'in-transit':
        return OrderStatus.transit;
      case 'delivered':
        return OrderStatus.delivered;
      default:
        return OrderStatus.unknown;
    }
  }

  String get value {
    switch (this) {
      case OrderStatus.created:
        return 'Created';
      case OrderStatus.processed:
        return 'Processed';
      case OrderStatus.assigned:
        return 'Assigned';
      case OrderStatus.transit:
        return 'In-transit';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.unknown:
        return '';
    }
  }
}