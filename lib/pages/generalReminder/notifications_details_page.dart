
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz; 
import 'package:timezone/timezone.dart' as tz;
import 'package:memoixx/main.dart';
import 'package:memoixx/pages/generalReminder/alarm_database_helper.dart';

class NotificationsRem {
late tz.Location? _local;
NotificationsRem() {
    tz.initializeTimeZones();
    _local = tz.local; 
  }
  void showNotifications(List<Alarm> alarms) async{

AndroidNotificationDetails androidDetails = const AndroidNotificationDetails(
  "channelId_mem", 
  "Memoix",
  enableVibration: true,
  priority: Priority.max,
  importance: Importance.max,
  );

  DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
    presentAlert: true,
    presentSound: true,
  );

  NotificationDetails notidetails = NotificationDetails(
    android: androidDetails,
    iOS: iosDetails,
  );

//We iterate through the alarms to set the notifications
//when we add new alarm it calls the noti(alarms) and sets the notifications

 for (Alarm alarm in alarms) {
      tz.TZDateTime scheduledDate = tz.TZDateTime.from(alarm.dateTime, _local!);
      await notifyplugin.zonedSchedule(
        alarm.id,
        alarm.text,
        alarm.textdesc,
        scheduledDate, //The error might be because of the local! Set far away times!
        notidetails,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true,
        payload:'${alarm.text}|${alarm.textdesc}',
      );
    }

  }
}