import 'package:equatable/equatable.dart';
import 'package:services/services.dart';

class DistanceMatrix extends Equatable {
  const DistanceMatrix._({
    required this.element,
    required this.endAddress,
    required this.startAddress,
  });

  factory DistanceMatrix.fromResponse(DistanceMatrixResponse response) {
    return DistanceMatrix._(
      element: DistanceElement.fromResponse(response.rows?.first),
      endAddress: response.destinationAddresses?.first ?? '',
      startAddress: response.originAddresses?.first ?? '',
    );
  }

  final String startAddress;
  final String endAddress;
  final DistanceElement element;

  @override
  List<Object?> get props => [startAddress, endAddress, element];
}

class DistanceElement extends Equatable {
  const DistanceElement._({
    required this.duration,
    required this.distance,
  });

  factory DistanceElement.fromResponse(DistanceRowResponse? response) {
    final row = response?.elements?.first;

    return DistanceElement._(
      duration: TextValueObject.fromResponse(row?.duration),
      distance: TextValueObject.fromResponse(row?.distance),
    );
  }

  final TextValueObject distance;
  final TextValueObject duration;

  @override
  List<Object?> get props => [distance, duration];
}

class TextValueObject extends Equatable {
  const TextValueObject._({
    required this.value,
    required this.text,
  });

  factory TextValueObject.empty() {
    return TextValueObject._(value: 0, text: '');
  }

  factory TextValueObject.fromResponse(TextValueObjectResponse? response) {
    return TextValueObject._(
      value: response?.value ?? 0,
      text: response?.text ?? '',
    );
  }

  final String text;
  final int value;

  bool get isEmpty => this == TextValueObject.empty();

  bool get isNotEmpty => this != TextValueObject.empty();

  @override
  List<Object?> get props => [text, value];
}
