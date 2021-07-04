import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:magic_express_delivery/src/data/api/api.dart';
import 'package:magic_express_delivery/src/di/constants.dart';
import 'package:magic_express_delivery/src/domain/domain.dart';

class Services {
  static Injector inject(Injector injector) {
    injector.map<IAuthService>(
      (injector) => AuthService(injector.get<ApiProvider>()),
      isSingleton: true,
      key: AUTH_SERVICE,
    );
    return injector;
  }
}
