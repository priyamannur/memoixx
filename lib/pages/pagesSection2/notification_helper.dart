
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz; 
import 'package:timezone/timezone.dart' as tz;
import 'package:memoixx/main.dart';
import 'package:memoixx/pages/pagesSection2/alarm_database_helper.dart';

class NotificationsHelper {
  static late tz.Location _local;

  static void initialize() {
    tz.initializeTimeZones();
    _local = tz.local;
  }

  static Future<void> showNotifications(List<dynamic> alarms) async {
    // Common notification details
    
    for (dynamic alarm in alarms) {
       String channelId = alarm is BillAlarmAdd ? "BillChannel" : "AlarmChannel";
      AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      channelId, 
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

      tz.TZDateTime scheduledDate;
      try {
        if (alarm is Alarm) {
          scheduledDate = tz.TZDateTime.from(alarm.dateTime, _local);
        } else if (alarm is BillAlarmAdd) {
          scheduledDate = tz.TZDateTime.from(alarm.dateTimeb, _local);
        } else {
          continue;
        }
      } catch (e) {
        print(e);
        return;
      }
      
       
      await notifyplugin.zonedSchedule(
        alarm is BillAlarmAdd ? alarm.idb : alarm.id,
        alarm is BillAlarmAdd ? alarm.textb : alarm.text,
        alarm is BillAlarmAdd ? alarm.priceb : alarm.textdesc,
        scheduledDate,
        notidetails,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true,
        payload: alarm is BillAlarmAdd ? '${alarm.textb}|Price:${alarm.priceb}' : '${alarm.text}|Descriprion:${alarm.textdesc}',
      );
    }
  }

  Future<void> deleteNotification(dynamic alarm) async {
  final List<PendingNotificationRequest> pendingNotifications =
      await notifyplugin.pendingNotificationRequests();

  int notId = alarm is BillAlarmAdd ? alarm.idb : alarm.id;
  bool notificationExists = pendingNotifications
      .any((notification) => notification.id == notId);
      print('Notification exists: $notificationExists');

  if (notificationExists) {
    await notifyplugin.cancel(notId);
}
}
}