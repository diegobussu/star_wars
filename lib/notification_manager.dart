import 'dart:async';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  static FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;

  static List<String> starWarsQuotes = [
    "May the Force be with you. - Obi-Wan Kenobi",
    "The Force will be with you, always. - Obi-Wan Kenobi",
    "I find your lack of faith disturbing. - Darth Vader",
    "Do. Or do not. There is no try. - Yoda",
    "In my experience, there's no such thing as luck. - Obi-Wan Kenobi",
    "Fear is the path to the dark side. Fear leads to anger; anger leads to hate; hate leads to suffering. - Yoda",
    "It's a trap! - Admiral Ackbar"
  ];

  static void initialize() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
    );

    _flutterLocalNotificationsPlugin!.initialize(initializationSettings);
  }

  static void startPeriodicNotifications() {
    print('Starting periodic notifications...');

    const IOSNotificationDetails iosPlatformChannelSpecifics =
        IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      iOS: iosPlatformChannelSpecifics,
    );

    // Envoyer une notification toutes les 30 secondes
    Timer.periodic(const Duration(seconds: 5), (timer) {
      print('Sending periodic notification...');
      // Choisissez une citation aléatoire de Star Wars
      String randomQuote = _getRandomStarWarsQuote();

      _flutterLocalNotificationsPlugin!.show(
        0,
        'Star Wars Quote',
        randomQuote,
        platformChannelSpecifics,
      );
    });
  }

  static String _getRandomStarWarsQuote() {
    Random random = Random();
    int index = random.nextInt(starWarsQuotes.length);
    String quote = starWarsQuotes[index];
    print('Selected quote: $quote');
    return quote;
  }
}
