import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magic_express_delivery/src/app/app.dart';

part 'process_delivery_state.dart';

class ProcessDeliveryCubit extends Cubit<ProcessDeliveryState> {
  ProcessDeliveryCubit({
    required CoordinatorCubit coordinatorCubit,
  }) : super(ProcessDeliveryState()) {
    final taskType = coordinatorCubit.state.taskType;
    if (taskType == TaskType.Errand) {
      emit(state.copyWith(paymentSelection: [true, false]));
    } else {
      emit(state.copyWith(paymentSelection: [true]));
    }
  }
}
