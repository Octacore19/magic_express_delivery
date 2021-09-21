import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/models/models.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:magic_express_delivery/src/utils/utils.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:repositories/repositories.dart';

part 'delivery_views.dart';

class DeliveryPage extends StatelessWidget {
  const DeliveryPage();

  static Route route() {
    return AppRoutes.generateRoute(
      child: DeliveryPage(),
      fullScreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery detail'),
      ),
      body: BlocProvider(
        create: (context) => DeliveryBloc(
          coordinatorCubit: BlocProvider.of(context),
          placesRepo: RepositoryProvider.of(context),
          errorHandler: RepositoryProvider.of(context),
          ordersRepo: RepositoryProvider.of(context),
        ),
        child: _DeliveryPageForm(),
      ),
    );
  }
}

class _DeliveryPageForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DeliveryPageFormState();
}

class _DeliveryPageFormState extends State<_DeliveryPageForm> {
  final _pickupAddressController = TextEditingController();
  final _deliveryAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context.read<DeliveryBloc>().state;
    TextUtil.setText(_pickupAddressController, state.pickupAddress);
    TextUtil.setText(_deliveryAddressController, state.deliveryAddress);
  }

  @override
  void dispose() {
    _pickupAddressController.dispose();
    _deliveryAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeliveryBloc, DeliveryState>(
      listener: (_, state) {
        if (state.success) {
          Navigator.of(context).push(FindRiderPage.route());
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 16),
              _PickUpAddressInput(_pickupAddressController),
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
