
enum PaymentType { cash, card }

extension PaymentTypeExtension on PaymentType {
  int get id {
    if (this == PaymentType.cash) {
      return 2;
    } else {
      return 1;
    }
  }

  String get name {
    if (this == PaymentType.cash) {
      return 'Cash';
    } else {
      return 'Card';
    }
  }
}