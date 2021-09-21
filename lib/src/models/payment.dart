
enum PaymentType { cash, card }

extension PaymentTypeExtension on PaymentType {
  int get id {
    if (this == PaymentType.cash) {
      return 1;
    } else {
      return 2;
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