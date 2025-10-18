import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:payrooll/homescreen.dart';
import 'package:payrooll/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/user.dart';

Future<void> main() async {
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
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const KeyboardVisibilityProvider(
        child: const AuthCheck(),
      ),
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool userAvailable=false;
  late SharedPreferences sp_;

  @override
  void initState(){
    super.initState();
    _getCurrentUser();

  }
  void _getCurrentUser() async{
        sp_ = await SharedPreferences.getInstance();
        try{
          if(sp_.getString('id')!=null){
            setState(() {
              User.username_ = sp_.getString('id')!;
              userAvailable=true;
            });
          }
        }catch(e){
          setState(() {
            userAvailable=false;
          });
        }
  }
  Widget build(BuildContext context) {
   // return userAvailable ? const Homescreen() :const LoginScreen();
     return const LoginScreen();
  }
}

