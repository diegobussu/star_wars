import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          iconTheme:
              const IconThemeData(color: Color.fromRGBO(238, 191, 47, 1))),
      body: Center(
        child: const Text('Settings Page'),
      ),
    );
  }
}
