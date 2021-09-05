
enum PersonnelType { unknown, sender, receiver, thirdParty }

extension PersonnelTypeExtension on PersonnelType {
  int get id {
    switch (this) {
      case PersonnelType.sender:
        return 1;
      case PersonnelType.receiver:
        return 2;
      case PersonnelType.thirdParty:
        return 3;
      default:
        return 0;
    }
  }

  String get name {
    switch (this) {
      case PersonnelType.sender:
        return 'Sender';
      case PersonnelType.receiver:
        return 'Receiver';
      case PersonnelType.thirdParty:
        return 'Third-Party';
      default:
        return 'Unknown';
    }
  }
}