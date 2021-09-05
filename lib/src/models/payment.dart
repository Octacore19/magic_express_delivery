
enum PaymentType { unknown, card, cash }

extension PaymentTypeExtension on PaymentType {
  int get id {
    if (this == PaymentType.cash) {
      return 1;
    } else if (this == PaymentType.card) {
      return 2;
    } else {
      return 0;
    }
  }

  String get name {
    if (this == PaymentType.cash) {
      return 'Cash';
    } else if (this == PaymentType.card) {
      return 'Card';
    } else {
      return 'Unknown';
    }
  }
}