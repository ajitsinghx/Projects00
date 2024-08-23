import 'package:flutter/material.dart';
import 'package:med_add/db/db_helper.dart';
import 'package:med_add/services/theme_services.dart';
import 'package:med_add/ui/homepage.dart';
import 'package:med_add/ui/theme.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:getma';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:med_add/services/notification_services.dart';
// void start() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await DBHelper.initDb();
//   await GetStorage.init();
//   // await NotifyHelper().init();
//   runApp( MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
  
      
      home: HomePage(),
    );
  }
}



