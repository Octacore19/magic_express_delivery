import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/models/models.dart';

part 'options_state.dart';

class OptionsCubit extends Cubit<OptionsState> {
  OptionsCubit({
    required CoordinatorCubit coordinator,
    required OrderType orderType,
  })  : _coordinator = coordinator,
        super(OptionsState.initial(orderType)) {
    _coordinator.setCurrentOrderType(orderType);
  }

  final CoordinatorCubit _coordinator;

  void onPersonnelSelected(int i) {
    var state = this.state;
    List<bool> p = List.from(state.personnelSelection);
    for (int index = 0; index < p.length; index++) {
      if (index == i) {
        p[index] = true;
        final type = PersonnelType.values[index + 1];
        state = state.copyWith(personnelType: type);
      } else {
        p[index] = false;
      }
    }
    state = state.copyWith(personnelSelection: p);
    if (state.errand) {
      _coordinator.setErrandOrder(ErrandOrder(
        orderType: state.orderType,
        personnelType: state.personnelType,
      ));
    } else {
      _coordinator.setDeliveryOrder(DeliveryOrder(
        orderType: state.orderType,
        personnelType: state.personnelType,
      ));
    }
    emit(state);
  }
}
