import 'package:UTS/Profile/profile.dart';
import 'package:UTS/register.dart';
import 'package:UTS/splash.dart';
import 'package:UTS/Profile/username.dart';
import 'package:flutter/material.dart';
import 'package:UTS/login.dart';
import 'package:UTS/myorder.dart';
import 'package:UTS/order.dart';
import 'package:UTS/menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:UTS/Profile/email.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //initialRoute: HalamanLogin.id,
      home: Splash(),
      routes: {
        HalamanLogin.id:(context) => HalamanLogin(),
        RegisterScreen.id: (context) => RegisterScreen(),
        UserDisplayName.id: (context) => UserDisplayName(),
        UserEmail.id: (context) => UserEmail(),
        MainMenu.id: (context) => MainMenu(),
        OrderMenu.id: (context) => OrderMenu(),
        MyOrder.id: (context) => MyOrder(),
        HalamanProfile.id: (context) => HalamanProfile(),
      },
    );
  }
}
