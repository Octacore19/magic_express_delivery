import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:magic_express_delivery/src/index.dart';

class Blocs {
  static Injector inject(Injector injector) {
    injector.map(
      (injector) => LoginBloc(injector.get(key: AUTH_REPO)),
      isSingleton: true,
    );
    injector.map(
      (injector) => RegistrationBloc(injector.get(key: AUTH_REPO)),
    );
    return injector;
  }
}
