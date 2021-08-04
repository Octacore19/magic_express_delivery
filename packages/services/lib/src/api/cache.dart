import 'package:services/src/impl/impl.dart';
import 'package:services/src/local/local.dart';

class Cache implements ICache {

  Cache();

  final _c = CacheImpl();

  @override
  Future<T?> read<T extends Object>({required String key}) => _c.read(key: key);

  @override
  void write<T extends Object>({required String key, required T value}) => _c.write(key: key, value: value);

}