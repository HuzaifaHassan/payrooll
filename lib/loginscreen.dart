import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController idController_ = TextEditingController();
  TextEditingController passwordController_ = TextEditingController();
  double screenHeight_ = 0;
  double screenWidth_ = 0;
  Color primary_ = const Color(0xFF1E90FF);

  @override
  Widget build(BuildContext context) {
    screenHeight_ = MediaQuery
        .of(context)
        .size
        .height;
    screenWidth_ = MediaQuery
        .of(context)
        .size
        .width;


    return Scaffold(
      body: Column(
        children: [
          Container(
            height: screenHeight_ / 2.5,
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
                size: screenWidth_ / 5,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top:
              screenHeight_ / 15,
              bottom: screenHeight_ / 20,
            ),
            child: Text(
                'Login',
                style: TextStyle(
                  fontSize: screenWidth_ / 18,
                  fontWeight: FontWeight.bold,
                )
            ),
          ),
          Container(alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(
              horizontal:
              screenWidth_ / 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FieldTitle("Employee ID"),
                customField("Enter Employee ID", idController_),
                FieldTitle("Password"),
                customField("Enter Password", passwordController_),
                Container(
                  child: Center(
                    child: Text("LOGIN"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget FieldTitle(String title) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 12,
      ),
      child: Text(
          title,
          style: TextStyle(
            fontSize: screenWidth_ / 26,
            fontWeight: FontWeight.bold,
          )
      ),
    );
  }
  Widget customField(String hint, TextEditingController controller){
      return  Container(
        width: screenWidth_,
        margin: EdgeInsets.only(
          bottom:  12,
        ),

        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(

              width: screenWidth_ / 6,
              child: Icon(
                Icons.person,
                color: primary_,
                size: screenWidth_ / 15,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: screenWidth_ / 12),
                child: TextFormField(
                  controller: controller,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                
                    hintText: hint,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: screenHeight_ / 35,
                      //horizontal: screenWidth_ / 20,
                    ),
                    border: InputBorder.none,
                
                    hintStyle: TextStyle(
                      fontSize: screenWidth_ / 26,
                    ),
                  ),
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      );
  }
}