import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:magic_express_delivery/src/index.dart';

final injector = ModuleContainer().init(Injector());

class ModuleContainer {
  Injector init(Injector injector) {
    Providers.inject(injector);
    Services.inject(injector);
    Repositories.inject(injector);
    Blocs.inject(injector);
    return injector;
  }
}