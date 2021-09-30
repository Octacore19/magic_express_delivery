part of 'cart_dialog.dart';

class _ItemNameInput extends StatelessWidget {
  const _ItemNameInput(this.controller);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.next,
      cursorColor: Colors.grey,
      onChanged: (s) {
        context.read<CartCubit>().onItemNameChanged(s);
      },
      decoration: InputDecoration(
        labelText: 'Item name',
        isDense: true,
        labelStyle: AppTheme.textFieldHeaderStyle(context),
        focusedBorder: AppTheme.textOutlineFocusedBorder(context),
        enabledBorder: AppTheme.textOutlineEnabledBorder(context),
        errorBorder: AppTheme.textOutlineErrorBorder(context),
        focusedErrorBorder: AppTheme.textOutlineFocusedBorder(context),
      ),
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  const _DescriptionInput(this.controller);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      cursorColor: Colors.grey,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.next,
      maxLines: null,
      onChanged: (s) {
        context.read<CartCubit>().onItemDescriptionChanged(s);
      },
      decoration: InputDecoration(
        labelText: 'Description',
        isDense: true,
        labelStyle: AppTheme.textFieldHeaderStyle(context),
        border: AppTheme.textOutlineEnabledBorder(context),
        focusedBorder: AppTheme.textOutlineFocusedBorder(context),
        enabledBorder: AppTheme.textOutlineEnabledBorder(context),
        errorBorder: AppTheme.textOutlineErrorBorder(context),
        focusedErrorBorder: AppTheme.textOutlineFocusedBorder(context),
      ),
    );
  }
}

class _QuantityInput extends StatelessWidget {
  const _QuantityInput(this.controller);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        onChanged: (s) {
          context.read<CartCubit>().onItemQuantityChanged(s);
        },
        decoration: InputDecoration(
          labelText: 'Quantity',
          isDense: true,
          labelStyle: AppTheme.textFieldHeaderStyle(context),
          focusedBorder: AppTheme.textUnderlineFocusedBorder(context),
          focusedErrorBorder: AppTheme.textUnderlineErrorFocusedBorder(context),
          enabledBorder: AppTheme.textUnderlineEnabledBorder(context),
          errorBorder: AppTheme.textUnderlineErrorBorder(context),
        ),
      ),
    );
  }
}

class _UnitPriceInput extends StatelessWidget {
  const _UnitPriceInput(this.controller);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(),
        onChanged: (s) {
          context.read<CartCubit>().onItemUnitPriceChanged(s);
        },
        decoration: InputDecoration(
          labelText: 'Unit Price',
          isDense: true,
          labelStyle: AppTheme.textFieldHeaderStyle(context),
          focusedBorder: AppTheme.textUnderlineFocusedBorder(context),
          focusedErrorBorder: AppTheme.textUnderlineErrorFocusedBorder(context),
          enabledBorder: AppTheme.textUnderlineEnabledBorder(context),
          errorBorder: AppTheme.textUnderlineErrorBorder(context),
        ),
      ),
    );
  }
}

class _ErrorDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(builder: (_, state) {
      if (!state.error && state.message.isEmpty) return SizedBox.shrink();
      return Padding(
        padding: EdgeInsets.only(top: 16),
        child: Row(
          children: [
            Icon(Icons.error, color: Colors.red, size: 16),
            const SizedBox(width: 8),
            Text(
              state.message,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    });
  }
}
