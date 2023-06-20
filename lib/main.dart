import 'package:chattest/Homepage.dart';
import 'package:chattest/screens/chatScreen.dart';
import 'package:chattest/screens/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  //Flutter engine이 실행전에 초기화되어야함
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        /*colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,*/
      ),
      //home: LoginSignupScreen(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData) {
            return ChatScreen();
          }
          return LoginSignupScreen();
        },
      ),
    );
  }
}
