import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/models/models.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:magic_express_delivery/src/utils/utils.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:repositories/repositories.dart';

part 'errand_views.dart';

class ErrandPage extends StatelessWidget {
  const ErrandPage();

  static Route route() {
    return AppRoutes.generateRoute(
      child: ErrandPage(),
      fullScreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order detail'),
      ),
      body: BlocProvider(
        create: (context) => ErrandBloc(
          coordinatorCubit: BlocProvider.of(context),
          placesRepo: RepositoryProvider.of(context),
          ordersRepo: RepositoryProvider.of(context),
          errorHandler: RepositoryProvider.of(context),
        ),
        child: _ErrandPageForm(),
      ),
    );
  }
}

class _ErrandPageForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ErrandPageFormState();
}

class _ErrandPageFormState extends State<_ErrandPageForm> {
  final _storeNameController = TextEditingController();
  final _storeAddressController = TextEditingController();
  final _deliveryAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context.read<ErrandBloc>().state;
    TextUtil.setText(_storeNameController, state.storeAddress);
    TextUtil.setText(_storeAddressController, state.storeAddress);
    TextUtil.setText(_deliveryAddressController, state.deliveryAddress);
  }

  @override
  void dispose() {
    _storeNameController.dispose();
    _storeAddressController.dispose();
    _deliveryAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ErrandBloc>().state;
    return BlocListener<ErrandBloc, ErrandState>(
      listener: (_, state) async {
        if (state.isPayStackPayment) {
          Navigator.of(context).push(PaystackPage.route(
            orderId: state.order.id.toString(),
            reference: state.order.reference,
            amount: state.totalAmount,
          ));
        } else if (state.success) {
          Navigator.of(context).push(FindRiderPage.route());
        }
      },
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _StoreNameInput(_storeNameController),
                  const SizedBox(height: 16),
                  _StoreAddressInput(_storeAddressController),
                  const SizedBox(height: 16),
                  _DeliveryAddressInput(_deliveryAddressController),
                  _DistanceCalculationView(),
                  const SizedBox(height: 48),
                  _ShoppingCartView(),
                  const SizedBox(height: 8),
                  _AddOrderButton(),
                  const SizedBox(height: 56.0),
                  _NextToProcessButton()
                ],
              ),
            ),
          ),
          Visibility(
            visible: state.loading && state.calculating,
            child: Container(
              height: 16,
              width: 16,
              margin: EdgeInsets.only(left: 16),
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade900),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
