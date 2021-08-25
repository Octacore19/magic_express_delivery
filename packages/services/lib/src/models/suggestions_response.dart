class SuggestionsResponse {
  SuggestionsResponse.fromJson(Map<String, dynamic> json)
      : predictions = json['predictions'];

  final List<_Prediction>? predictions;

  @override
  String toString() {
    return 'SuggestionsResponse(predictions: $predictions)';
  }
}

class _Prediction {
  _Prediction.fromJson(Map<String, dynamic> json)
      : placeId = json['place_id'],
        description = json['description'];

  final String? placeId;
  final String? description;

  @override
  String toString() {
    return 'Prediction(placeId: $placeId, description: $description)';
  }
}
