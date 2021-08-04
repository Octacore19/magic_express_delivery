// @dart=2.9

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:repositories/repositories.dart';
import 'package:services/services.dart';

import 'src/app/app.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  final cache = Cache();
  final authService = AuthService.getInstance(cache);
  final authRepo = AuthRepo.getInstance(cache: cache, authService: authService);
  await authRepo.status.first;
  runApp(App(authRepo: authRepo));
}
