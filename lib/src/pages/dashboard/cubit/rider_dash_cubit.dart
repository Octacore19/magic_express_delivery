import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:magic_express_delivery/rider.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/models/models.dart';
import 'package:repositories/repositories.dart';
import 'package:workmanager/workmanager.dart';

class RiderDashCubit extends Cubit<RiderDashState> with HydratedMixin {
  RiderDashCubit({
    required MiscRepo miscRepo,
    required ErrorHandler errorHandler,
  })  : _miscRepo = miscRepo,
        _handler = errorHandler,
        super(RiderDashState.init()) {
    if (state.riderAvailability) {
      _registerBackgroundTask();
    } else {
      if (!Platform.isIOS)
      Workmanager().cancelAll();
    }
  }

  final MiscRepo _miscRepo;
  final ErrorHandler _handler;

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

  void toggleRiderAvailability(bool value) async {
    emit(state.copyWith(riderAvailability: value));
    try {
      if (value) {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            _handler.handleExceptions(NoPermissionException());
          }
        } else if (permission == LocationPermission.deniedForever) {
          _handler.handleExceptions(NoPermissionException(
            'Location permissions are permanently denied, we cannot request permissions.',
          ));
        } else {
          await _miscRepo.updateAvailability(value);
          if (value) {
            _registerBackgroundTask();
          } else {
            if (!Platform.isIOS)
            Workmanager().cancelAll();
          }
        }
      } else {
        await _miscRepo.updateAvailability(value);
        if (value) {
          _registerBackgroundTask();
        } else {
          if (!Platform.isIOS)
          Workmanager().cancelAll();
        }
      }
    } on Exception catch (e) {
      emit(state.copyWith(
        status: Status.error,
        riderAvailability: !value,
      ));
      _handler.handleExceptions(e);
    }
  }

  void _registerBackgroundTask() {
    if (Platform.isIOS) {
      Workmanager().registerOneOffTask(
        "1",
        LocationUpdateTask,
        constraints: Constraints(networkType: NetworkType.connected),
      );
    } else if (Platform.isAndroid) {
      Workmanager().registerPeriodicTask(
        "1",
        LocationUpdateTask,
        frequency: Duration(minutes: 30),
        constraints: Constraints(networkType: NetworkType.connected),
      );
    }
  }

  @override
  RiderDashState? fromJson(Map<String, dynamic> json) =>
      RiderDashState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(RiderDashState state) => state.toJson();
}

class RiderDashState extends Equatable {
  const RiderDashState._({
    required this.pages,
    required this.riderAvailability,
    required Status status,
  }) : _status = status;

  factory RiderDashState.init() {
    return RiderDashState._(
      pages: RiderDashPages.ORDER,
      riderAvailability: false,
      status: Status.initial,
    );
  }

  final bool riderAvailability;
  final RiderDashPages pages;
  final Status _status;

  RiderDashState copyWith({
    RiderDashPages? pages,
    bool? riderAvailability,
    Status? status,
  }) {
    return RiderDashState._(
      pages: pages ?? this.pages,
      riderAvailability: riderAvailability ?? this.riderAvailability,
      status: status ?? _status,
    );
  }

  factory RiderDashState.fromJson(Map<String, dynamic> json) {
    return RiderDashState._(
      pages: RiderDashPages.ORDER,
      riderAvailability: json['available'],
      status: Status.initial,
    );
  }

  Map<String, dynamic> toJson() {
    return {'available': riderAvailability};
  }

  @override
  List<Object?> get props => [
        pages,
        riderAvailability,
        _status,
      ];
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
