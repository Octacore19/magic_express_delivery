import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magic_express_delivery/src/models/models.dart';
import 'package:repositories/repositories.dart';

part 'coordinator_state.dart';

class CoordinatorCubit extends Cubit<OrderType> {
  CoordinatorCubit() : super(OrderType.unknown);

  final _cartItemsController =
      BehaviorSubject<List<CartItem>>.seeded(List.empty());
  final _errandOrderController = ReplaySubject<ErrandOrder>(maxSize: 1);
  final _deliveryOrderController = ReplaySubject<DeliveryOrder>(maxSize: 1);

  void setCartItems(List<CartItem> items) =>
      _cartItemsController.sink.add(items);

  Stream<List<CartItem>> get cartItems => _cartItemsController.stream;

  void setErrandOrder(ErrandOrder order) =>
      _errandOrderController.sink.add(order);

  Stream<ErrandOrder> get errandOrder => _errandOrderController.stream;

  void setDeliveryOrder(DeliveryOrder order) =>
      _deliveryOrderController.sink.add(order);

  Stream<DeliveryOrder> get deliveryOrder => _deliveryOrderController.stream;

  void setCurrentOrderType(OrderType type) {
    emit(type);
  }

  bool get errand => this.state == OrderType.errand;

  @override
  Future<void> close() {
    _cartItemsController.close();
    _errandOrderController.close();
    _deliveryOrderController.close();
    return super.close();
  }
}
