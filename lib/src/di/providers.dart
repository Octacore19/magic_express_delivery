import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:magic_express_delivery/src/index.dart';

class Providers {
  static Injector inject(Injector injector) {
    injector.map<IPreferences>(
      (injector) => Preferences(),
      isSingleton: true,
    );
    
    final provider = ApiProvider(ApiConstants.BASE_URL, preferences: injector.get<IPreferences>());
    provider.init();
    provider.setInterceptors();
    injector.map((injector) => provider);
    return injector;
  }
}
