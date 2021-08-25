import 'package:services/src/contracts/contracts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesImpl implements LocalService {
  PreferencesImpl() {
    _pref = SharedPreferences.getInstance();
  }

  late Future<SharedPreferences> _pref;

  @override
  void clear() async {
    final pref = await _pref;
    pref.clear();
  }

  @override
  Future<T?> read<T extends Object>({required String key}) async {
    try {
      final pref = await _pref;
      if (T is String) {
        return pref.getString(key) as T;
      } else if (T is int) {
        return pref.getInt(key) as T;
      } else if (T is bool) {
        return pref.getBool(key) as T;
      }
    } catch(e) {
      throw e;
    }
  }

  @override
  void remove({required String key}) async {
    try {
      final pref = await _pref;
      pref.remove(key);
    } catch(e) {
      throw e;
    }
  }

  @override
  void write<T extends Object>({required String key, required T value}) async {
    try {
      final pref = await _pref;
      if (T is String) {
        pref.setString(key, value as String);
      } else if (T is int) {
        pref.setInt(key, value as int);
      } else if (T is bool) {
        pref.setBool(key, value as bool);
      }
    } catch(e) {
      throw e;
    }
  }
}
