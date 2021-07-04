import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:magic_express_delivery/src/data/data.dart';
import 'package:magic_express_delivery/src/di/constants.dart';
import 'package:magic_express_delivery/src/domain/domain.dart';

class Repositories {
  static Injector inject(Injector injector) {
    injector.map<IAuthRepo>(
      (injector) => AuthRepo(injector.get(key: AUTH_SERVICE)),
      isSingleton: true,
      key: AUTH_REPO,
    );
    return injector;
  }
}
