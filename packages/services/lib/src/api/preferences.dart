import 'package:services/src/contracts/contracts.dart';
import 'package:services/src/impl/preferences.dart';

class Preferences implements LocalService {
  final _pref = PreferencesImpl();

  @override
  void clear() => _pref.clear();

  @override
  Future<T?> read<T extends Object>({required String key}) =>
      _pref.read(key: key);

  @override
  void remove({required String key}) => _pref.remove(key: key);

  @override
  Future<void> write<T extends Object>({required String key, required T value}) =>
      _pref.write(key: key, value: value);
}
