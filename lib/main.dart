import 'package:fltr_pdascan/Pages/home_page.dart';
import 'package:fltr_pdascan/Pages/login_page.dart';
import 'package:fltr_pdascan/Pages/uhf_scan_page.dart';

import 'package:fltr_pdascan/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constants.prefs = await SharedPreferences.getInstance();
  //runApp(MyApp());
  runApp(GetMaterialApp(
    initialRoute:
        Constants.prefs.getBool("PDASCR_LOGGED_IN") == true ? 'home' : 'login',
    getPages: [
      GetPage(name: '/home', page: () => HomePage()),
      GetPage(name: '/login', page: () => LoginPage()),
      GetPage(name: '/uhf_scan', page: () => UHFScanPage()),
      //GetPage(name: '/scanner', page: () => ScannerPage()),
    ],
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Constants.prefs.getBool("PDASCR_LOGGED_IN") == true
          ? HomePage()
          : LoginPage(),
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        HomePage.routeName: (context) => HomePage(),
      },
    );
  }
}
