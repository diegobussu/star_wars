import 'dart:async';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  static FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;

  // Liste des citations de Star Wars
  static List<String> starWarsQuotes = [
    "Que la Force soit avec toi. - Obi-Wan Kenobi",
    "La Force sera toujours avec toi. - Obi-Wan Kenobi",
    "Je trouve votre manque de foi troublant. - Dark Vador",
    "Fais-le ou ne le fais pas. Il n'y a pas d'essai. - Yoda",
    "À mon expérience, il n'y a pas de chance. - Obi-Wan Kenobi",
    "La peur mène au côté obscur. La peur mène à la colère; la colère mène à la haine; la haine mène à la souffrance. - Yoda",
    "C'est un piège! - Amiral Ackbar"
  ];

  // Initialisation du plugin de notifications locales
  static void initialize() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Paramètres d'initialisation spécifiques à iOS
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

    // Initialisation du plugin avec les paramètres
    _flutterLocalNotificationsPlugin!.initialize(initializationSettings);
  }

  // Démarrage des notifications périodiques
  static void startPeriodicNotifications() {
    print('Démarrage des notifications périodiques...');

    // Détails spécifiques à iOS pour les notifications
    const IOSNotificationDetails iosPlatformChannelSpecifics =
        IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      iOS: iosPlatformChannelSpecifics,
    );

    // Envoi d'une notification toutes les 5 secondes
    Timer.periodic(const Duration(seconds: 5), (timer) {
      print('Envoi d\'une notification périodique...');
      // Sélection d'une citation aléatoire de Star Wars
      String randomQuote = _getRandomStarWarsQuote();

      // Affichage de la notification
      _flutterLocalNotificationsPlugin!.show(
        0,
        'Citation Star Wars',
        randomQuote,
        platformChannelSpecifics,
      );
    });
  }

  // Fonction privée pour obtenir une citation aléatoire de Star Wars
  static String _getRandomStarWarsQuote() {
    Random random = Random();
    int index = random.nextInt(starWarsQuotes.length);
    String quote = starWarsQuotes[index];
    print('Citation sélectionnée : $quote');
    return quote;
  }
}
