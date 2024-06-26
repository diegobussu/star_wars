import 'dart:async';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  static FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;
  static Timer? _notificationTimer; // Timer pour les notifications périodiques

  static List<String> starWarsQuotes = [
    "Que la Force soit avec toi. - Obi-Wan Kenobi",
    "La Force sera toujours avec toi. - Obi-Wan Kenobi",
    "Je trouve votre manque de foi troublant. - Dark Vador",
    "Fais-le ou ne le fais pas. Il n'y a pas d'essai. - Yoda",
    "À mon expérience, il n'y a pas de chance. - Obi-Wan Kenobi",
    "La peur mène au côté obscur. La peur mène à la colère; la colère mène à la haine; la haine mène à la souffrance. - Yoda",
    "C'est un piège! - Amiral Ackbar"
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
    print('Démarrage des notifications périodiques.');
    const IOSNotificationDetails iosPlatformChannelSpecifics =
        IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      iOS: iosPlatformChannelSpecifics,
    );

    _notificationTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      print('Envoi d\'une notification périodique.');
      String randomQuote = _getRandomStarWarsQuote();

      _flutterLocalNotificationsPlugin!.show(
        0,
        'Citation Star Wars',
        randomQuote,
        platformChannelSpecifics,
      );
    });
  }

  static void stopPeriodicNotifications() {
    print('Arrêt des notifications.');
    _notificationTimer?.cancel();
  }

  static String _getRandomStarWarsQuote() {
    Random random = Random();
    int index = random.nextInt(starWarsQuotes.length);
    String quote = starWarsQuotes[index];
    print('Citation sélectionnée : $quote');
    return quote;
  }
}
