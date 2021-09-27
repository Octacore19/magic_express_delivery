import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:repositories/repositories.dart';

import 'app_view.dart';

class App extends StatefulWidget {
  const App([this.isRider = false]);

  final bool isRider;

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final WidgetsBinding _binding = WidgetsBinding.instance!;

  @override
  void initState() {
    _binding.addObserver(this);
    super.initState();
    FirebaseMessaging.onMessage.listen((message) {
      print('Got a message whilst in the foreground!');
      print('Message from: ${message.from}');
      print('Message category: ${message.category}');
      print('Message id: ${message.messageId}');
      print('Message type: ${message.messageType}');
      print('Message senderId: ${message.senderId}');
      print('Message from: ${message.sentTime}');

      final data = message.data;


      final notification = message.notification;

      if (notification != null) {
        print('Notification title: ${notification.title}');
        print('Notification content: ${notification.body}');
      }
    });
  }

  @override
  void dispose() {
    _binding.removeObserver(this);
    context.read<AuthRepo>().dispose();
    context.read<PlacesRepo>().dispose();
    context.read<UsersRepo>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AppBloc(
            authRepo: RepositoryProvider.of(context),
            ordersRepo: RepositoryProvider.of(context),
            isRider: widget.isRider
          ),
        ),
        BlocProvider(create: (_) => CoordinatorCubit())
      ],
      child: AppView(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        context.read<AuthRepo>().dispose();
        context.read<PlacesRepo>().dispose();
        context.read<UsersRepo>().dispose();
        break;
    }
  }
}
