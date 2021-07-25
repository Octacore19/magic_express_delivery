abstract class Item {
  final String? _item;
  final String? _description;
  final int? _quantity;

  Item(String? item, String? description, int? quantity)
      : _item = item,
        _description = description,
        _quantity = quantity;

  @override
  String toString() {
    return 'Item(item: $_item, description: $_description, quantity: $_quantity)';
  }
}
