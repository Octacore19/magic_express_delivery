import 'package:bloc/bloc.dart';

class DashBoardCubit extends Cubit<DashboardPages> {
  DashBoardCubit() : super(DashboardPages.HOME);

  void setCurrentPage(int index) {
    switch (index) {
      case 0:
        emit(DashboardPages.HOME);
        break;
      case 1:
        emit(DashboardPages.HISTORY);
        break;
      case 2:
        emit(DashboardPages.PROFILE);
        break;
    }
  }
}

enum DashboardPages { HOME, HISTORY, PROFILE }

extension DashboardPagesExtension on DashboardPages {
  int get position {
    switch (this) {
      case DashboardPages.HOME:
        return 0;
      case DashboardPages.HISTORY:
        return 1;
      case DashboardPages.PROFILE:
        return 2;
    }
  }
}
