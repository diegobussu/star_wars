import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../notification_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    String buttonText =
        notificationsEnabled ? 'Disable Notifications' : 'Enable Notifications';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Color.fromRGBO(238, 191, 47, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color.fromRGBO(238, 191, 47, 1)),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Switch(
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                  buttonText = notificationsEnabled
                      ? 'Disable Notifications'
                      : 'Enable Notifications';
                });
                if (notificationsEnabled) {
                  NotificationManager.startPeriodicNotifications();
                } else {
                  NotificationManager.stopPeriodicNotifications();
                }
              },
              activeTrackColor: const Color.fromRGBO(238, 191, 47, 1),
              activeColor: Colors.black,
              inactiveTrackColor: Colors.black,
              inactiveThumbColor: Color.fromRGBO(238, 191, 47, 1),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  notificationsEnabled = !notificationsEnabled;
                  buttonText = notificationsEnabled
                      ? 'Disable Notifications'
                      : 'Enable Notifications';
                });
                if (notificationsEnabled) {
                  NotificationManager.startPeriodicNotifications();
                } else {
                  NotificationManager.stopPeriodicNotifications();
                }
              },
              child: Text(
                buttonText,
                style: const TextStyle(
                  color: Colors.yellow, // Couleur du texte en jaune
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
