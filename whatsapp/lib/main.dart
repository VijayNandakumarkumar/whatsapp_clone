import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/pages/CameraPage.dart';
import 'package:whatsapp/screens/HomeScreen.dart';
import 'package:whatsapp/screens/LoginScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'WhatsApp',
        theme: ThemeData(
            fontFamily: "OpenSans",
            primaryColor: Color(0xFF075E54),
            accentColor: Color(0xFF128C7E)),
        debugShowCheckedModeBanner: false,
        home: LoginScreen());
  }
}
