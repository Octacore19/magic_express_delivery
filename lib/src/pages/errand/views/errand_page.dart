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
          places: RepositoryProvider.of(context),
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
    TextUtil.setText(_storeAddressController, state.deliveryAddress);
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
    return BlocListener<ErrandBloc, ErrandState>(
      listener: (_, state) {},
      child: SingleChildScrollView(
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
              const SizedBox(height: 8),
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
    );
  }
}
