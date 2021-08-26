import 'package:repositories/src/contracts/contracts.dart';
import 'package:repositories/src/impl/places.dart';
import 'package:repositories/src/models/models.dart';
import 'package:services/services.dart';

class Places implements IPlaces {

  Places({required PlacesService service}) {
    _repo = PlacesImpl(service);
  }

  late IPlaces _repo;

  @override
  Future<List<Prediction>> searchForPlaces(String keyword) => _repo.searchForPlaces(keyword);
}
