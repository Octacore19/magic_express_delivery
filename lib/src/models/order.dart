
enum OrderType { unknown, delivery, errand }

extension OrderTypeExtension on OrderType {
  int get id {
    if (this == OrderType.errand) {
      return 2;
    } else if (this == OrderType.delivery) {
      return 1;
    } else {
      return 0;
    }
  }

  String get name {
    if (this == OrderType.errand) {
      return 'Errand';
    } else if (this == OrderType.delivery) {
      return 'Delivery';
    } else {
      return 'Unknown';
    }
  }
}