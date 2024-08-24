import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rurux_assignment/data/controller/localdata_controller.dart';
import 'package:rurux_assignment/views/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut<SharedPreferences>(() => sharedPreferences);

  Get.lazyPut(() => LocalDataController(sharedPreferences: Get.find()));

  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Rurux Assignment',
      home: const HomeScreen(),
    );
  }
}
