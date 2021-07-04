import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:magic_express_delivery/src/di/constants.dart';
import 'package:magic_express_delivery/src/index.dart';

class Blocs {
  static Injector inject(Injector injector) {
    injector.map(
      (injector) => LoginBloc(injector.get(key: AUTH_REPO)),
      isSingleton: true,
    );
    return injector;
  }
}
