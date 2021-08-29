import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'coordinator_state.dart';

class CoordinatorCubit extends Cubit<CoordinatorState> {
  CoordinatorCubit() : super(CoordinatorState());

  void setTaskType(TaskType type) {
    emit(state.copyWith(taskType: type));
  }

  void setDeliveryType(DeliveryType type) {
    emit(state.copyWith(deliveryType: type));
  }
}