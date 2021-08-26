import 'package:services/src/contracts/contracts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesImpl implements LocalService {
  PreferencesImpl() {
    _pref = SharedPreferences.getInstance();
  }

  late Future<SharedPreferences> _pref;

  @override
  void clear() async {
    try {
      final pref = await _pref;
      pref.clear();
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<T?> read<T extends Object>({required String key}) async {
    try {
      T? value;
      await _pref.then((pref) {
        value = pref.get(key) as T;
      });
      return value;
    } catch (e) {
      throw e;
    }
  }

  @override
  void remove({required String key}) async {
    try {
      final pref = await _pref;
      pref.remove(key);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> write<T extends Object>({
    required String key,
    required T value,
  }) async {
    try {
      final pref = await _pref;
      bool completed = false;
      if (value is String) {
        completed = await pref.setString(key, value);
      } else if (value is int) {
        completed = await pref.setInt(key, value);
      } else if (value is bool) {
        completed = await pref.setBool(key, value);
      }
      if (completed) return;
    } catch (e) {
      throw e;
    }
  }
}
