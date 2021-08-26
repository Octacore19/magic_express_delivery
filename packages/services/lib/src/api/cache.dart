import 'package:services/src/contracts/contracts.dart';
import 'package:services/src/impl/impl.dart';

class Cache implements LocalService {

  Cache();

  final _cache = CacheImpl();

  @override
  Future<T?> read<T extends Object>({required String key}) => _cache.read(key: key);

  @override
  Future<void> write<T extends Object>({required String key, required T value}) => _cache.write(key: key, value: value);

  @override
  void remove({required String key}) => _cache.remove(key: key);

  @override
  void clear() => _cache.clear();
}