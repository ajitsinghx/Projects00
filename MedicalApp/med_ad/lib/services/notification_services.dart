
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:med_add/models/task.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;
import 'package:get/get.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:med_add/controllers/task_controller.dart';
import 'package:med_add/ui/widgets/task_file.dart';
import 'package:med_add/ui/add_task_bar.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:med_add/db/db_helper.dart';
import 'package:med_add/services/theme_services.dart';
import 'package:med_add/ui/widgets/button.dart';
import 'package:med_add/ui/widgets/input_field.dart';
import 'package:med_add/ui/homepage.dart';
import 'package:med_add/ui/theme.dart';
import 'package:med_add/ui/theme.dart';
import 'package:med_add/MyApp.dart';




class NotifyHelper{
  FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); //

  initializeNotification() async {
  _configureLocalTimezone();
  final DarwinInitializationSettings initializationSettingsIOS =
     DarwinInitializationSettings(
         requestSoundPermission: false,
         requestBadgePermission: false,
         requestAlertPermission: false,
         onDidReceiveLocalNotification: onDidReceiveLocalNotification
     );


 final AndroidInitializationSettings initializationSettingsAndroid =
     AndroidInitializationSettings("appicon");

    final InitializationSettings initializationSettings =
        InitializationSettings(
       iOS: initializationSettingsIOS,
       android:initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        // onSelectNotification:selectNotification
        //  onDidReceiveNotificationResponse: selectNotification
        );
  }

  Future<void> displayNotification({required String title, required String body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = 
    new AndroidNotificationDetails(

        'your channel id', 'your channel name', /*'your channel description',*/
        importance: Importance.max, priority: Priority.high);

    var iOSPlatformChannelSpecifics = new DarwinNotificationDetails();

    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics, 
        iOS: iOSPlatformChannelSpecifics);
        
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  scheduledNotification(int hour, int minutes, Task task) async {
     
     await flutterLocalNotificationsPlugin.zonedSchedule(
         task.id!.toInt(),
         task.medicine,
         task.dosage,
         _convertTime(hour, minutes),
        //  tz.TZDateTime.now(tz.local).add(const Duration(seconds:5 )),
         const NotificationDetails(
             android: AndroidNotificationDetails('your channel id',
                 'your channel name', /*'your channel description'*/)),
             androidAllowWhileIdle: true,
             uiLocalNotificationDateInterpretation:
             UILocalNotificationDateInterpretation.absoluteTime,
             matchDateTimeComponents: DateTimeComponents.time,
            //  matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
             payload: "{$task.medicine}"+"{$task.dosage}!"
            );

   }

   tz.TZDateTime _convertTime(int hour,int minutes){
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = 
        tz.TZDateTime(tz.local, now.year, now.month,now.day,hour,minutes);

        if(scheduleDate.isBefore(now)){

          scheduleDate = scheduleDate.add(const Duration(days:1));
        }
        return scheduleDate;
   }

   Future<void> _configureLocalTimezone() async{
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
   }

   

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future selectNotification(String? payload) async {
    if(payload != null) {
      print('notification payload: $payload');
    }
    else{
      print('Notification Done');
    }
    Get.to(()=>Container(color: Colors.white,));
  }

  

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    
    Get.dialog(Text("hi"));
  }
}