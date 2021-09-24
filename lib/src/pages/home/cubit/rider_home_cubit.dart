import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:repositories/repositories.dart';

part 'rider_home_state.dart';

class RiderHomeCubit extends Cubit<RiderHomeState> {
  RiderHomeCubit() : super(RiderHomeState.init());
}
