import 'package:repositories/src/contracts/contracts.dart';
import 'package:repositories/src/impl/places.dart';
import 'package:repositories/src/models/models.dart';
import 'package:repositories/src/models/place_detail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:services/services.dart';

class PlacesRepo implements IPlacesRepo {

  PlacesRepo({required ApiProvider api}) {
    _repo = PlacesRepoImpl(api);
  }

  late IPlacesRepo _repo;

  final _pickupController = PublishSubject<PlaceDetail>();
  final _destinationController = PublishSubject<PlaceDetail>();

  Stream<PlaceDetail> get destinationDetail async* {
    yield const PlaceDetail.empty();
    yield* _destinationController.stream;
  }

  Stream<PlaceDetail> get pickupDetail async* {
    yield const PlaceDetail.empty();
    yield* _pickupController.stream;
  }

  @override
  Future<List<Prediction>> searchForPlaces(String keyword) => _repo.searchForPlaces(keyword);

  Future<void> fetchPickupDetail(String id) async {
    try {
      final detail = await fetchDetail(id);
      _pickupController.sink.add(detail);
      return;
    } catch(e) {
      throw e;
    }
  }

  Future<void> fetchDestinationDetail(String id) async {
    try {
      final detail = await fetchDetail(id);
      _destinationController.sink.add(detail);
      return;
    } catch(e) {
      throw e;
    }
  }

  void close() {
    _pickupController.close();
    _destinationController.close();
  }

  @override
  Future<PlaceDetail> fetchDetail(String placeId) => _repo.fetchDetail(placeId);
}
