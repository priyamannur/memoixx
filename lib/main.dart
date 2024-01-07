import 'package:flutter/material.dart';
import 'package:memoixx/pages/pagesSection2/alarm_database_helper.dart';
import 'package:memoixx/pages/pagesSection2/landing_page.dart';
import 'package:memoixx/pages/pagesSection2/notification_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

  FlutterLocalNotificationsPlugin notifyplugin = FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
 
  void main() async {
  WidgetsFlutterBinding.ensureInitialized();

await AlarmHelper().initializeDatabase();

  AndroidInitializationSettings androidInitializationSettings = const AndroidInitializationSettings('reminder_image');

  DarwinInitializationSettings iosInitializationSettings = const DarwinInitializationSettings(
requestAlertPermission: true,
requestBadgePermission: true,
requestCriticalPermission: true,
requestSoundPermission: true,
  );

  InitializationSettings initializationSettings = InitializationSettings(
android: androidInitializationSettings,
iOS: iosInitializationSettings,
  );


  await notifyplugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response){
      final payload = response.payload;
      if(payload!=null && payload.isNotEmpty){
         final parts = payload.split('|');
    if (parts.length == 2) {
      final String title = parts[0];
      final String body = parts[1];
   
             navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (context) => NotifyPage(title:title, body:body)),);
    }
    }
      }
  );


     runApp(const MyApp());

 }


class MyApp extends StatelessWidget {


 const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memoix demo',
      theme: ThemeData(
        primaryColor: Colors.indigo.shade900, 
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.indigo,
      ),
      scaffoldBackgroundColor: Colors.white, 
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.indigo.shade900, 
        ),
        useMaterial3: true,
      ),
      navigatorKey: navigatorKey,
      home: const MyHomePage("Its About time"),
    
    );
  }
}

