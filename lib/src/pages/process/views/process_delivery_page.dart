import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:magic_express_delivery/src/utils/utils.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

part 'process_delivery_views.dart';

class ProcessDeliveryPage extends StatelessWidget {
  const ProcessDeliveryPage();

  static Route route() => AppRoutes.generateRoute(
        child: ProcessDeliveryPage(),
        fullScreenDialog: true,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Process delivery'),
      ),
      body: BlocProvider(
        create: (context) => ProcessDeliveryCubit(
          coordinatorCubit: BlocProvider.of(context),
        ),
        child: _ProcessDeliveryForm(),
      ),
    );
  }
}

class _ProcessDeliveryForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProcessDeliveryState();
}

class _ProcessDeliveryState extends State<_ProcessDeliveryForm> {
  final _senderNameController = TextEditingController();
  final _senderPhoneController = TextEditingController();
  final _receiverNameController = TextEditingController();
  final _receiverPhoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final bloc = context.read<ProcessDeliveryCubit>();
    TextUtil.setText(_senderNameController, bloc.state.senderName);
    TextUtil.setText(_senderPhoneController, bloc.state.senderPhone);
    TextUtil.setText(_receiverNameController, bloc.state.receiverName);
    TextUtil.setText(_receiverPhoneController, bloc.state.receiverPhone);

    _senderNameController.addListener(() {
      final value = _senderNameController.text.trim();
      bloc.onSenderNameChanged(value);
    });
    _senderPhoneController.addListener(() {
      final value = _senderPhoneController.text.trim();
      bloc.onSenderPhoneChanged(value);
    });
    _receiverNameController.addListener(() {
      final value = _receiverNameController.text.trim();
      bloc.onReceiverNameChanged(value);
    });
    _receiverPhoneController.addListener(() {
      final value = _receiverPhoneController.text.trim();
      bloc.onReceiverPhoneChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProcessDeliveryCubit, ProcessDeliveryState>(
      builder: (_, state) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24),
              _NameInput(
                header: "Sender's Full Name",
                controller: _senderNameController,
                visible: state.senderVisible,
              ),
              Visibility(
                  child: const SizedBox(height: 24),
                  visible: state.senderVisible),
              _PhoneNumberInput(
                header: "Sender's Phone Number",
                controller: _senderPhoneController,
                visible: state.senderVisible,
              ),
              Visibility(
                  child: const SizedBox(height: 24), visible: state.thirdParty),
              _NameInput(
                header: "Receiver's Full Name",
                controller: _receiverNameController,
                visible: state.receiverVisible,
              ),
              Visibility(
                  child: const SizedBox(height: 24),
                  visible: state.receiverVisible),
              _PhoneNumberInput(
                header: "Receiver's Phone Number",
                controller: _receiverPhoneController,
                visible: state.receiverVisible,
              ),
              const SizedBox(height: 16),
              _DeliveryNoteView(),
              const SizedBox(height: 24),
              _PaymentOptionsView(),
              const SizedBox(height: 56),
              _NextToSummaryButton(),
            ],
          ),
        ),
      ),
    );
  }
}
