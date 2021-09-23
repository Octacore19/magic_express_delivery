import 'package:bloc/bloc.dart';

class UserDashCubit extends Cubit<UserDashPages> {
  UserDashCubit() : super(UserDashPages.HOME);

  void setCurrentPage(int index) {
    switch (index) {
      case 0:
        emit(UserDashPages.HOME);
        break;
      case 1:
        emit(UserDashPages.HISTORY);
        break;
      case 2:
        emit(UserDashPages.PROFILE);
        break;
    }
  }
}

enum UserDashPages { HOME, HISTORY, PROFILE }

extension UserDashPagesExtension on UserDashPages {
  int get position {
    switch (this) {
      case UserDashPages.HOME:
        return 0;
      case UserDashPages.HISTORY:
        return 1;
      case UserDashPages.PROFILE:
        return 2;
    }
  }
}
