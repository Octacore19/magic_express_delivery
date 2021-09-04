import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:repositories/repositories.dart';

part 'coordinator_state.dart';

class CoordinatorCubit extends Cubit<Null> {
  CoordinatorCubit() : super(null);

  final _taskTypeController = BehaviorSubject<TaskType?>();
  final _deliveryTypeController = BehaviorSubject<DeliveryType?>();
  final _cartItemsController = BehaviorSubject<List<CartItem>?>();
  final _senderNameController = BehaviorSubject<String?>();
  final _senderPhoneController = BehaviorSubject<String?>();
  final _receiverNameController = BehaviorSubject<String?>();
  final _receiverPhoneController = BehaviorSubject<String?>();
  final _deliveryNoteController = BehaviorSubject<String?>();
  final _storeNameController = BehaviorSubject<String?>();
  final _paymentTypeController = BehaviorSubject<PaymentType?>();

  void setTaskType(TaskType type) => _taskTypeController.sink.add(type);

  Stream<TaskType?> get taskType => _taskTypeController.stream;

  void setDeliveryType(DeliveryType type) => _deliveryTypeController.sink.add(type);

  Stream<DeliveryType?> get deliveryType => _deliveryTypeController.stream;

  void setCartItems(List<CartItem> items) => _cartItemsController.sink.add(items);

  Stream<List<CartItem>?> get cartItems => _cartItemsController.stream;

  void setSenderName(String? value) => _senderNameController.sink.add(value);

  Stream<String?> get senderName => _senderNameController.stream;

  void setSenderPhone(String? value) => _senderPhoneController.sink.add(value);

  Stream<String?> get senderPhoneNumber => _senderPhoneController.stream;

  void setReceiverName(String? value) => _receiverNameController.sink.add(value);

  Stream<String?> get receiverName => _receiverNameController.stream;

  void setReceiverPhone(String? value) => _receiverPhoneController.sink.add(value);

  Stream<String?> get receiverPhoneNumber => _receiverPhoneController.stream;

  void setDeliveryNote(String? value) => _deliveryNoteController.sink.add(value);

  Stream<String?> get deliveryNote => _deliveryNoteController.stream;

  void setPaymentType(PaymentType? type) => _paymentTypeController.sink.add(type);

  Stream<PaymentType?> get paymentType => _paymentTypeController.stream;

  void setStoreName(String? value) => _storeNameController.sink.add(value);

  Stream<String?> get storeName => _storeNameController.stream;

  @override
  Future<void> close() {
    _taskTypeController.close();
    _deliveryTypeController.close();
    _cartItemsController.close();
    _senderNameController.close();
    _senderPhoneController.close();
    _receiverNameController.close();
    _receiverPhoneController.close();
    _deliveryNoteController.close();
    _storeNameController.close();
    _paymentTypeController.close();
    return super.close();
  }
}