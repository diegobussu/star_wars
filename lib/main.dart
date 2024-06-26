import 'package:flutter/material.dart';
import 'screens/navigation.dart';

import 'notification_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationManager.initialize();
  NotificationManager.startPeriodicNotifications();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyBottomNavigationBar(),
    );
  }
}
