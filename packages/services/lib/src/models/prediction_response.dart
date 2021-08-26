class PredictionResponse {
  PredictionResponse.fromJson(Map<String, dynamic> json)
      : placeId = json['place_id'],
        description = json['description'];

  final String? placeId;
  final String? description;

  @override
  String toString() {
    return '$runtimeType(placeId: $placeId, description: $description)';
  }
}
