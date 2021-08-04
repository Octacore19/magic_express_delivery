abstract class ICache {

  void write<T extends Object>({required String key, required T value});

  Future<T?> read<T extends Object>({required String key});
}