import 'dart:developer';

import 'package:services/src/local/local.dart';

class CacheImpl implements ICache {

  CacheImpl() : _cache = <String, Object>{};

  final Map<String, Object> _cache;

  @override
  void write<T extends Object>({required String key, required T value}) async {
    log('Value saved to cache => $value');
    _cache[key] = value;
  }

  @override
  Future<T?> read<T extends Object>({required String key}) async {
    final value = _cache[key];
    log('Value gotten from cache => $value');
    if (value is T) return value;
    return null;
  }
}