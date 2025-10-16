import 'package:flutter/material.dart';

class Todayscreen extends StatefulWidget {
  const Todayscreen({super.key});

  @override
  State<Todayscreen> createState() => _TodayscreenState();
}

class _TodayscreenState extends State<Todayscreen> {
  double screenHeight_ = 0;
  double screenWidth_ = 0;
  Color primary_ = const Color( 0xFF1E90FF);

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
              margin: const EdgeInsets.only(top:32),
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
              margin: const EdgeInsets.only(top:32),
              child:Text(
                "Today's Status",
                style:TextStyle(
                  color: Colors.black54,
                  fontSize: screenHeight_ / 32 ,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top:12, bottom: 32),
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
                borderRadius: BorderRadius.all(Radius.circular(20)),

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    Expanded(

                      child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Text(
                                "Check In",
                            style: TextStyle(
                          fontSize: screenWidth_/20,
                         color: Colors.black54,
                         // fontWeight: FontWeight.bold,
                        ),
                            ),
                            Text
                              (
                              "9:30",
                              style: TextStyle(
                                fontSize: screenWidth_/18,
                                 fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                    ),
                  Expanded(

                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Text(
                                  "Check Out",
                                style: TextStyle(
                                  fontSize: screenWidth_/20,
                                  color: Colors.black54,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text
                                (
                                "15:30",
                                style: TextStyle(
                                 fontSize:screenWidth_ / 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                  ),
                  ],
            ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                  text: TextSpan(
                    text:"11",
                    style: TextStyle(
                      fontSize: screenWidth_/18,
                      color: primary_,
                      // fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: "Oct 2025",
                        style: TextStyle(
                          fontSize: screenWidth_/20,
                          color: Colors.black,
                      ),
                      ),
                    ],
                  ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "20:00:01",
                style: TextStyle(
                  fontSize: screenWidth_/20,
                  color: Colors.black54,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),

          ],
        ),
      )

    );
  }
}
