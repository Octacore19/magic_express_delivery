import 'package:magic_express_delivery/src/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences implements IPreferences {
  late Future<SharedPreferences> _preferences;

  Preferences() {
    _preferences = SharedPreferences.getInstance();
  }

  setData(String key, dynamic value) async {
    final pref = await _preferences;
    if (value is String) {
      pref.setString(key, value);
    } else if (value is int) {
      pref.setInt(key, value);
    }
  }

  Future getData(String key, dynamic defaultValue) async {
    final pref = await _preferences;
    if (defaultValue is String) {
      return pref.getString(key) ?? defaultValue;
    } else if (defaultValue is int) {
      return pref.getInt(key) ?? defaultValue;
    }
  }
}
