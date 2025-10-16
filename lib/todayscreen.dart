import 'package:flutter/material.dart';

class Todayscreen extends StatefulWidget {
  const Todayscreen({super.key});

  @override
  State<Todayscreen> createState() => _TodayscreenState();
}

class _TodayscreenState extends State<Todayscreen> {
  double screenHeight_ = 0;
  double screenWidth_ = 0;


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
    return  Scaffold(
      body:SingleChildScrollView(
        padding:EdgeInsets.all(20),
        child:Column(
          children:[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top:32),
              child:Text(
                "Welcome",
                style:TextStyle(
                  color: Colors.black54,
                  fontSize: screenHeight_ / 35,
              ),
            ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child:Text(
                "Employee",
                style:TextStyle(
                  color: Colors.black54,
                  fontSize: screenHeight_ / 25 ,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top:32),
              child:Text(
                "Today's Status",
                style:TextStyle(
                  color: Colors.black54,
                  fontSize: screenHeight_ / 25 ,
                ),
              ),
            ),
            Container(
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                  color:Colors.black26,
                  blurRadius: 10,
                    offset: Offset(2,2),
                   ),
               ],
              ),
            ),
          ],
        ),
      )

    );
  }
}
