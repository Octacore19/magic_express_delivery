import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/errand/bloc/errand_bloc.dart';
import 'package:magic_express_delivery/src/errand/views/errand_views.dart';
import 'package:magic_express_delivery/src/options/options.dart';

class ErrandPage extends StatelessWidget {
  const ErrandPage();

  static Route route([BuildContext? context]) {
    if (context != null) {
      return AppRoutes.generateRouteBuilder(
        builder: (_) => BlocProvider.value(
          value: BlocProvider.of<OptionsCubit>(context),
          child: ErrandPage(),
        ),
      );
    }
    return AppRoutes.generateRoute(ErrandPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order detail'),
      ),
      body: BlocProvider(
        create: (context) => ErrandBloc(BlocProvider.of<OptionsCubit>(context)),
        child: ErrandPageForm(),
      ),
    );
  }
}

class ErrandPageForm extends StatelessWidget {
  final _itemNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ErrandBloc>().state;
    _setText(_itemNameController, state.itemName);
    _setText(_descriptionController, state.description);
    _setText(_quantityController, state.quantity);
    _setText(_priceController, state.unitPrice);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            StoreNameInput(),
            const SizedBox(height: 8.0),
            StoreAddressInput(),
            const SizedBox(height: 8.0),
            DeliveryAddressInput(),
            const SizedBox(height: 16.0),
            ShoppingCartView(),
            const SizedBox(height: 8.0),
            ItemNameInput(_itemNameController),
            const SizedBox(height: 8.0),
            DescriptionInput(_descriptionController),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                QuantityInput(_quantityController),
                const SizedBox(width: 96.0),
                UnitPriceInput(_priceController)
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: AddOrderButton(),
            ),
            const SizedBox(height: 56.0),
            NextToProcessButton()
          ],
        ),
      ),
    );
  }

  void _setText(TextEditingController controller, String text) {
    controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.fromPosition(
        TextPosition(offset: text.length),
      ),
    );
  }
}
