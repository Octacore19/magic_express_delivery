import 'package:equatable/equatable.dart';

class Prediction extends Equatable {
  Prediction({required this.id, required this.description});

  final String id;
  final String description;

  @override
  String toString() {
    return '$runtimeType(id: $id, description: $description)';
  }

  @override
  List<Object?> get props => [id, description];
}
