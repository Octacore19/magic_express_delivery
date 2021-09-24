import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:repositories/repositories.dart';

class RiderDashCubit extends Cubit<RiderDashState> with HydratedMixin {
  RiderDashCubit() : super(RiderDashState.init());

  void setCurrentPage(int index) {
    switch (index) {
      case 0:
        emit(state.copyWith(pages: RiderDashPages.ORDER));
        break;
      case 1:
        emit(state.copyWith(pages: RiderDashPages.PROFILE));
        break;
    }
  }

  void toggleRiderAvailability(bool value) {
    emit(state.copyWith(riderAvailability: value));
  }

  @override
  RiderDashState? fromJson(Map<String, dynamic> json) => RiderDashState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(RiderDashState state) => state.toJson();
}

class RiderDashState extends Equatable {
  const RiderDashState._({
    required this.pages,
    required this.riderAvailability,
  });

  factory RiderDashState.init() {
    return RiderDashState._(
      pages: RiderDashPages.ORDER,
      riderAvailability: false,
    );
  }

  final bool riderAvailability;
  final RiderDashPages pages;

  RiderDashState copyWith({
    RiderDashPages? pages,
    bool? riderAvailability,
  }) {
    return RiderDashState._(
      pages: pages ?? this.pages,
      riderAvailability: riderAvailability ?? this.riderAvailability,
    );
  }

  factory RiderDashState.fromJson(Map<String, dynamic> json) {
    return RiderDashState._(
      pages: RiderDashPages.ORDER,
      riderAvailability: json['available'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'available': riderAvailability};
  }

  @override
  List<Object?> get props => [pages, riderAvailability];
}

enum RiderDashPages { ORDER, PROFILE }

extension RiderDashPagesExtension on RiderDashPages {
  int get position {
    switch (this) {
      case RiderDashPages.ORDER:
        return 0;
      case RiderDashPages.PROFILE:
        return 1;
    }
  }
}
