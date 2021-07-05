// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class BaseModel extends Equatable {
  const BaseModel();

  @override
  List<Object> get props => [];
}
