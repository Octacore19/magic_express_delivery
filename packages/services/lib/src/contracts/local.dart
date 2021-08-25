abstract class LocalService {
  void write<T extends Object>({required String key, required T value});

  Future<T?> read<T extends Object>({required String key});

  void remove({required String key});

  void clear();
}