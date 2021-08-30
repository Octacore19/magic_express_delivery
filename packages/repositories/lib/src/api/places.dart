import 'dart:async';

import 'package:repositories/src/contracts/contracts.dart';
import 'package:repositories/src/impl/places.dart';
import 'package:repositories/src/models/models.dart';
import 'package:rxdart/rxdart.dart';
import 'package:services/services.dart';

class PlacesRepo implements IPlacesRepo {
  PlacesRepo({required ApiProvider api}) {
    _repo = PlacesRepoImpl(api);
  }

  late IPlacesRepo _repo;

  final _pickupController = PublishSubject<PlaceDetail>();
  final _destinationController = PublishSubject<PlaceDetail>();

  late Stream<List<Prediction>> _result;

  Stream<List<Prediction>> get result => _result;

  Stream<PlaceDetail> get destinationDetail async* {
    yield const PlaceDetail.empty();
    yield* _destinationController.stream;
  }

  Stream<PlaceDetail> get pickupDetail async* {
    yield const PlaceDetail.empty();
    yield* _pickupController.stream;
  }

  Future<void> fetchPickupDetail(String id) async {
    try {
      final detail = await fetchDetail(id);
      _pickupController.sink.add(detail);
      return;
    } catch (e) {
      throw e;
    }
  }

  Future<void> fetchDestinationDetail(String id) async {
    try {
      final detail = await fetchDetail(id);
      _destinationController.sink.add(detail);
      return;
    } catch (e) {
      throw e;
    }
  }

  void close() {
    _pickupController.close();
    _destinationController.close();
  }

  @override
  Future<List<Prediction>> searchForPlaces(String keyword) =>
      _repo.searchForPlaces(keyword);

  @override
  Future<PlaceDetail> fetchDetail(String placeId) => _repo.fetchDetail(placeId);
}
