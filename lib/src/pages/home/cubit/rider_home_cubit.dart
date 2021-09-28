import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/models/models.dart';
import 'package:repositories/repositories.dart';

part 'rider_home_state.dart';

class RiderHomeCubit extends Cubit<RiderHomeState> {
  RiderHomeCubit({
    required RidersRepo ridersRepo,
    required ErrorHandler errorHandler,
  })  : _ridersRepo = ridersRepo,
        _handler = errorHandler,
        super(RiderHomeState.init()) {
    _orderSubscription = ridersRepo.history.listen((history) {
      emit(state.copyWith(history: history));
    });
  }

  final RidersRepo _ridersRepo;
  final ErrorHandler _handler;

  late StreamSubscription _orderSubscription;

  @override
  Future<void> close() {
    _orderSubscription.cancel();
    return super.close();
  }
}
