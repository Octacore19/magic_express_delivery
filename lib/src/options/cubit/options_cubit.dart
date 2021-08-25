import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'options_state.dart';

class OptionsCubit extends Cubit<OptionsState> {
  OptionsCubit()
      : super(OptionsState());

  void setCurrentPosition(Object? args) {
    int position = args as int;
    emit(state.copyWith(position: position));
  }

  void onPersonnelSelected(int i) {
    int id = state.personnelIndex;
    List<bool> p = List.from(state.personnelSelection);
    for (int index = 0; index < p.length; index++) {
      if (index == i) {
        p[index] = true;
        id = index;
      } else {
        p[index] = false;
      }
    }
    bool s = p.contains(true);
    emit(state.copyWith(personnelIndex: id, personnelSelection: p, personnelSelected: s));
  }
}
