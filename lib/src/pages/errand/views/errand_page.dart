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
          miscRepo: RepositoryProvider.of(context),
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
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  side: BorderSide(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16.0),
                    Text(
                      'New Order Created',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16.0),
                    Image(
                      image: AssetImage(AppImages.DELIVERY_IMAGE),
                      height: MediaQuery.of(context).size.width * 0.25,
                      width: MediaQuery.of(context).size.width * 0.25,
                    ),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Your order has been created. Please proceed to make payment.",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(PaystackPage.route(
                            orderId: state.order.id.toString(),
                            reference: state.order.reference,
                            amount: state.totalAmount,
                          ));
                        },
                        child: Text('PROCEED'),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          textStyle: Theme.of(context)
                              .textTheme
                              .button
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state.success) {
          showDialog(
            context: context,
            builder: (context) {
              Future.delayed(Duration(seconds: 5)).then((value){
                Navigator.of(context).popUntil((route) => route.isFirst);
              });
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  side: BorderSide(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16.0),
                    Text(
                      'New Order Created',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16.0),
                    Image(
                      image: AssetImage(AppImages.DELIVERY_IMAGE),
                      height: MediaQuery.of(context).size.width * 0.25,
                      width: MediaQuery.of(context).size.width * 0.25,
                    ),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Your order has been created. We'll notify you when a rider has been assigned to your order.",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
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
