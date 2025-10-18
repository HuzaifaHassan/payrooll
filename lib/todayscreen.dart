import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/user.dart';

class Todayscreen extends StatefulWidget {
  const Todayscreen({super.key});

  @override
  State<Todayscreen> createState() => _TodayscreenState();
}

class _TodayscreenState extends State<Todayscreen> {
  double screenHeight_ = 0;
  double screenWidth_ = 0;
  String checkIn="--/--";
  String checkOut="--/--";
  String todayDay = DateFormat('EEEE').format(DateTime.now());
  String? userId_;

  Color primary_ = const Color( 0xFF1E90FF);
@override
  void initState() {

    super.initState();
   // _getRecord();
    _loadUserId();
  }
  void _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');

    if (id == null || id.isEmpty) {
      print("⚠️ No user ID found in SharedPreferences");
      // Optionally redirect to login
      return;
    }

    print("✅ Loaded user ID: $id");

    setState(() {
      userId_ = id;
    });

    // Pass the ID directly to _getRecord
    _getRecord(id);
  }
  void _getRecord(String id) async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("Employee")
          .where('id', isEqualTo: id)
          .get();

      if (snap.docs.isEmpty) {
        print("⚠️ No employee found with id: $id");
        setState(() {
          checkIn = "--/--";
          checkOut = "--/--";
        });
        return;
      }

      DocumentSnapshot dsnap = await FirebaseFirestore.instance
          .collection("Employee")
          .doc(snap.docs[0].id)
          .collection("Record")
          .doc(DateFormat(' dd MMMM yy ').format(DateTime.now()))
          .get();

      if (dsnap.exists) {
        setState(() {
          checkIn = dsnap['checkIn'];
          checkOut = dsnap['checkOut'];
        });
        print("✅ Record loaded successfully");
      } else {
        print("⚠️ No record document found for today");
        setState(() {
          checkIn = "--/--";
          checkOut = "--/--";
        });
      }
    } catch (e) {
      print("🔥 Error fetching record: $e");
      setState(() {
        checkIn = "--/--";
        checkOut = "--/--";
      });
    }
  }
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
                userId_! ,
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
                              checkIn,
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
                                checkOut,
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
                    text: DateTime.now().day.toString(),
                    style: TextStyle(
                      fontSize: screenWidth_/18,
                      color: primary_,
                      // fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: DateFormat(' MMMM yy ').format(DateTime.now()),
                        style: TextStyle(
                          fontSize: screenWidth_/20,
                          color: Colors.black,
                      ),
                      ),
                    ],
                  ),
              ),
            ),
            StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, asyncSnapshot) {
                return Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DateFormat('hh:mm:ss a').format(DateTime.now()),
                    style: TextStyle(
                      fontSize: screenWidth_/20,
                      color: Colors.black54,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
            ),
            checkOut == "--/--" ? Container(
              margin: const EdgeInsets.only(top: 32),
              child: Builder(
                builder: (context) {
                  final GlobalKey<SlideActionState> key = GlobalKey();
               return  SlideAction(

                          text: checkIn == "--/--" ?" Slide To Check In" : "Slide To Check Out",
                           textStyle: TextStyle(
                             fontSize: screenWidth_/20,
                             color: Colors.white54,
                            // fontWeight: FontWeight.bold,
                           ),
                          outerColor: primary_,
                          innerColor: Colors.white,
                          key: key,
                          onSubmit: () async {
                            Timer(Duration(seconds: 1),(){
                              key.currentState!.reset();
                            });
                            //key.currentState!.reset();
                            //print(DateFormat('hh:mm').format(DateTime.now()));
                            QuerySnapshot snap = await FirebaseFirestore.instance
                                .collection("Employee").where('id', isEqualTo: userId_).get();

                           // print(snap.docs[0].id);
                            DocumentSnapshot dsnap= await FirebaseFirestore.instance .collection("Employee")
                                .doc(snap.docs[0].id)
                                .collection("Record").doc(DateFormat(' dd MMMM yy ').format(DateTime.now()))
                                .get();
                          try{
                            String checkIn = dsnap['checkIn'];
                            setState(() {
                              checkOut = DateFormat('hh:mm').format(DateTime.now());
                            });
                            await  FirebaseFirestore.instance
                                .collection("Employee")
                                .doc(snap.docs[0].id)
                                .collection("Record").doc(DateFormat(' dd MMMM yy ').format(DateTime.now())).update(
                                {'checkIn' : checkIn,
                                  'checkOut' : DateFormat('hh:mm').format(DateTime.now()),
                                  'day':todayDay,
                                });
                          }
                          catch(e){
                            setState(() {
                              checkIn = DateFormat('hh:mm').format(DateTime.now());
                            });
                            await  FirebaseFirestore.instance
                                .collection("Employee")
                                .doc(snap.docs[0].id)
                                .collection("Record").doc(DateFormat(' dd MMMM yy ').format(DateTime.now())).set(
                                {'checkIn' : DateFormat('hh:mm').format(DateTime.now()),
                                  'checkOut' : '--/--',
                                  'day':todayDay,
                                });
                          }
                          },
                  );
                },

              ),
            ): Container(
              margin: const EdgeInsets.only(top: 32),
              child: Text
                (
                  "You have Completed this day!",
                style: TextStyle(
                fontSize : screenWidth_ /20,
                color: Colors.black54,
                ),
              ),
            )
          ],
        ),
      )

    );
  }
}
