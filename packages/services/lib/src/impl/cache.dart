import 'package:services/src/local/local.dart';

class CacheImpl implements ICache {

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
}