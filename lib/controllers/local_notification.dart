import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;



class LocalNotification{

  final FlutterLocalNotificationsPlugin _locationNotificationService=FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings androidInitializationSettings=const AndroidInitializationSettings("logo");

  Future<void> initialize()async{
    final InitializationSettings settings = InitializationSettings(
        android: androidInitializationSettings,
    );
    await _locationNotificationService.initialize(settings);
  }


  void notificationSend(String title,String body)async{

    AndroidNotificationDetails details=const AndroidNotificationDetails(
        "channelId",
        "channelName",
      importance: Importance.max,
      priority: Priority.max
    );
    NotificationDetails notificationDetails=NotificationDetails(android: details);
     await _locationNotificationService.show(
        0,
        title,
        body,
        notificationDetails
    );
  }


  void scheduleNotificationSend({String? title,String?body,String?payload,required DateTime? schedule})async{
    AndroidNotificationDetails details=const AndroidNotificationDetails(
        "channelId",
        "channelName",
        importance: Importance.max,
        priority: Priority.max
    );
    NotificationDetails notificationDetails=NotificationDetails(android: details);
     await _locationNotificationService.zonedSchedule(
         0,
         title,
         body,
         tz.TZDateTime.from(schedule!,tz.local),
         notificationDetails,
         androidAllowWhileIdle: true,
         uiLocalNotificationDateInterpretation:
         UILocalNotificationDateInterpretation.absoluteTime);
  }
}
