import 'package:repositories/repositories.dart';

abstract class IPlaces {
  Future<List<Prediction>> searchForPlaces(String keyword);
}