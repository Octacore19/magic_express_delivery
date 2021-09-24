part of 'rider_home_cubit.dart';

class RiderHomeState extends Equatable {
  RiderHomeState._({
    required this.riderAvailable,
  });

  factory RiderHomeState.init() {
    return RiderHomeState._(
      riderAvailable: false,
    );
  }

  final bool riderAvailable;

  RiderHomeState copyWith({
    bool? riderAvailable,
  }) {
    return RiderHomeState._(
      riderAvailable: riderAvailable ?? this.riderAvailable,
    );
  }

  factory RiderHomeState.fromJson(Map<String, dynamic> json) {
    return RiderHomeState._(riderAvailable: json['available']);
  }

  Map<String, dynamic> toJson() {
    return {'available': riderAvailable};
  }

  @override
  List<Object?> get props => [riderAvailable];
}
