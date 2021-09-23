import 'package:bloc/bloc.dart';

class RiderDashCubit extends Cubit<RiderDashPages> {
  RiderDashCubit() : super(RiderDashPages.ORDER);

  void setCurrentPage(int index) {
    switch (index) {
      case 0:
        emit(RiderDashPages.ORDER);
        break;
      case 1:
        emit(RiderDashPages.PROFILE);
        break;
    }
  }
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