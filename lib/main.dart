import 'package:flutter/material.dart';
import 'package:psinder/app/psinder_app.dart';
import 'package:psinder/services/persistence_service.dart';

PersistenceService get _persistenceService => PersistenceService.build();

bool get isTesting => _isTesting;
set isTesting(bool value) {
  _persistenceService.setTesting(value);
  _isTesting = value;
}

bool _isTesting;

Future<void> main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();

  await refreshIsTesting();

  binding
    ..attachRootWidget(PsinderApp.build())
    ..scheduleWarmUpFrame();
}

Future<void> refreshIsTesting() async {
  _isTesting = await _persistenceService.getTesting() ?? false;
}
