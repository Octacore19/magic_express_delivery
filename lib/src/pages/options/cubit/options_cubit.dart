import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';

part 'options_state.dart';

class OptionsCubit extends Cubit<OptionsState> {
  OptionsCubit({required CoordinatorCubit coordinator})
      : _coordinator = coordinator,
        super(OptionsState()) {
    _taskSub = _coordinator.taskType.listen((type) {
      emit(state.copyWith(taskType: type));
    });
    _deliverySub = _coordinator.deliveryType.listen((type) {
      emit(state.copyWith(deliveryType: type));
    });
  }

  final CoordinatorCubit _coordinator;
  late StreamSubscription _taskSub;
  late StreamSubscription _deliverySub;

  void onPersonnelSelected(int i) {
    DeliveryType type = state.deliveryType;
    _coordinator.setDeliveryType(type);
    List<bool> p = List.from(state.personnelSelection);
    for (int index = 0; index < p.length; index++) {
      if (index == i) {
        p[index] = true;
        type = DeliveryType.values[index];
      } else {
        p[index] = false;
      }
    }
    emit(state.copyWith(personnelSelection: p));
  }

  @override
  Future<void> close() {
    _taskSub.cancel();
    _deliverySub.cancel();
    return super.close();
  }
}
