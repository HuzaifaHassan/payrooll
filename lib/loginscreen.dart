import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double screenHeight_=0;
  double screenWidth_=0;
  Color primary_ =const Color(0xFF1E90FF);
  @override
  Widget build(BuildContext context) {
    screenHeight_=MediaQuery.of(context).size.height;
    screenWidth_ =MediaQuery.of(context).size.width;


    return Scaffold(
      body: Column(
        children: [
           Container(
              height: screenHeight_ /2.5,
              width: screenWidth_,
              decoration: BoxDecoration(
              color: primary_,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(70),
                ),
           ),
             child: Center(
               child: Icon(
                 Icons.person,
                 color: Colors.white,
                 size: screenWidth_ /5,
               ),
             ),
           ),
          Container(
            margin: EdgeInsets.only(
                top:
                screenHeight_ /15,
                bottom: screenHeight_ /20,
            ),
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: screenWidth_ /18,
                fontWeight: FontWeight.bold,
              )
            ),
          ),
          Container(alignment: Alignment.centerLeft,
              child: Text(
                  "Employee ID",
                style: TextStyle(
                fontSize: screenWidth_ /26,
                fontWeight: FontWeight.bold,
              )
              ),
          ),
        ],
      ),
    );
  }
}
