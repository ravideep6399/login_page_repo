import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:login_page_hillfare/login_widget.dart';
import 'package:login_page_hillfare/utils.dart';
import 'package:login_page_hillfare/welcome_page.dart';
import 'auth_page.dart';
import 'dart:ui';
import 'home_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAPNoWbnGUaeRF8XnPU0-G_LJBRGB7UN7Y",
      appId: "1:868222655855:android:f1b62e82fec35fcb429c9a",
      messagingSenderId: "868222655855",
      projectId: "login-page-hillfare-96b32",
    ),
  );

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Hillfare 2k22',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Something Went Wrong!'),
          );
        } else if (snapshot.hasData) {
          return HomePage();
        } else {
          return WelcomePage();
        }
      },
    ));
  }
}
