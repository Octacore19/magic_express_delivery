import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:magic_express_delivery/src/utils/utils.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

part 'errand_views.dart';

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

class ErrandPageForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ErrandPageFormState();
}

class _ErrandPageFormState extends State<ErrandPageForm> {

  @override
  Widget build(BuildContext context) {
    return BlocListener<ErrandBloc, ErrandState>(
      listener: (_, state) {
        /*TextUtil.setText(_itemNameController, state.itemName);
        TextUtil.setText(_descriptionController, state.description);
        TextUtil.setText(_quantityController, state.quantity);
        TextUtil.setText(_priceController, state.unitPrice);*/
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 16),
              _StoreNameInput(),
              const SizedBox(height: 16),
              _StoreAddressInput(),
              const SizedBox(height: 16),
              _DeliveryAddressInput(),
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
    );
  }
}
