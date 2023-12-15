import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:main_project/view/about_place/about_place.dart';
import 'package:main_project/view/about_hotel/hotel_home_screen.dart';
import 'package:main_project/view/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyD-Cifka7d64iTwiD-dVpanauNpeufDDnI",
          appId: "1:788002784149:android:43d9d4dd0437f93aacac9c",
          messagingSenderId: "",
          projectId: "ente-yatra"));
  await Hive.initFlutter();
  await Hive.openBox('userBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white70),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        'details': (context) => AboutPlacesScreen(),
        'hotels': (context) => HotelHomeScreen(),
      },
    );
  }
}
