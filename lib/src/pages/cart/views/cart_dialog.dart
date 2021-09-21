import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:magic_express_delivery/src/utils/utils.dart';

part 'cart_views.dart';

class CartDialog extends StatelessWidget {
  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => CartCubit(
          coordinatorCubit: BlocProvider.of(context),
        ),
        child: CartDialog(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(16),
      actions: [
        TextButton(
          child: Text('Save'),
          onPressed: () {
            FocusScope.of(context).unfocus();
            context.read<CartCubit>().onItemAdded();
          },
        ),
        TextButton(
          child: Text('Finish'),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
      ],
      content: _CartForm(),
    );
  }
}

class _CartForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CartFormState();
}

class _CartFormState extends State<_CartForm> {
  final _itemNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context.read<CartCubit>().state;
    TextUtil.setText(_itemNameController, state.itemName);
    TextUtil.setText(_descriptionController, state.description);
    TextUtil.setText(_quantityController, state.quantity);
    TextUtil.setText(_priceController, state.unitPrice);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocListener<CartCubit, CartState>(
        listener: (_, state) {
          TextUtil.setText(_itemNameController, state.itemName);
          TextUtil.setText(_descriptionController, state.description);
          TextUtil.setText(_quantityController, state.quantity);
          TextUtil.setText(_priceController, state.unitPrice);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add an item', style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 24),
            _ItemNameInput(_itemNameController),
            const SizedBox(height: 24),
            _DescriptionInput(_descriptionController),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _QuantityInput(_quantityController),
                const SizedBox(width: 72),
                _UnitPriceInput(_priceController)
              ],
            ),
            _ErrorDisplay(),
          ],
        ),
      ),
    );
  }
}
