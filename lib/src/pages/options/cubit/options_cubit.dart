import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';

part 'options_state.dart';

class OptionsCubit extends Cubit<OptionsState> {
  OptionsCubit({required CoordinatorCubit coordinator})
      : _coordinator = coordinator,
        super(OptionsState()) {
    final type = _coordinator.state.taskType;
    emit(state.copyWith(taskType: type));
  }

  final CoordinatorCubit _coordinator;

  void onPersonnelSelected(int i) {
    DeliveryType type = state.deliveryType;
    List<bool> p = List.from(state.personnelSelection);
    for (int index = 0; index < p.length; index++) {
      if (index == i) {
        p[index] = true;
        switch (index) {
          case 0:
            type = DeliveryType.Sender;
            break;
          case 1:
            type = DeliveryType.Receiver;
            break;
          case 2:
            type = DeliveryType.ThirdParty;
            break;
        }
      } else {
        p[index] = false;
      }
    }
    _coordinator.setDeliveryType(type);
    emit(state.copyWith(deliveryType: type, personnelSelection: p));
  }
}
