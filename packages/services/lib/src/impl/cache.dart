import 'package:services/src/contracts/contracts.dart';

class CacheImpl implements LocalService {

  CacheImpl() : _cache = <String, Object>{};

  final Map<String, Object> _cache;

  @override
  void write<T extends Object>({required String key, required T value}) async {
    _cache[key] = value;
  }

  @override
  Future<T?> read<T extends Object>({required String key}) async {
    final value = _cache[key];
    if (value is T) return value;
    return null;
  }

  @override
  void remove({required String key}) {
    _cache.remove(key);
  }

  @override
  void clear() {
    _cache.clear();
  }
}