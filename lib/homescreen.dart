
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payrooll/calenderscreen.dart';
import 'package:payrooll/profilescreen.dart';
import 'package:payrooll/todayscreen.dart';
class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  double screenHeight_ = 0;
  double screenWidth_ = 0;
  Color primary_ = const Color( 0xFF1E90FF);
  int currentindex_=1;
  List<IconData> navigationIcon=[
    FontAwesomeIcons.calendarAlt,
    FontAwesomeIcons.check,
    FontAwesomeIcons.user,


  ];

  @override
  Widget build(BuildContext context) {
   // final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(context);


    screenHeight_ = MediaQuery
        .of(context)
        .size
        .height;
    screenWidth_ = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      body: IndexedStack(
        index: currentindex_,
        children: const [
          Calenderscreen(),
          Todayscreen(),
          Profilescreen(),

        ],
      ),
    bottomNavigationBar: Container(
      height: 70  ,
      margin: const EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 24

      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:   BorderRadius.all(Radius.circular(40)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2,2),


        ),
      ],
     ),
      child: ClipRRect(
        borderRadius:  const BorderRadius.all(Radius.circular(40)),
        child: Row(
         crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                for(int i = 0; i < navigationIcon.length; i++)...<Expanded>{
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          currentindex_=i;
                        });
                      },
                      child: Container(
                         height: screenHeight_,
                         width: screenWidth_,
                         color: Colors.white,
                      child: Center(
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Icon(navigationIcon[i],
                                color: i == currentindex_ ? primary_ : Colors.black54,
                              size: i == currentindex_ ? 30:26,
                            ),
                            i == currentindex_ ? Container(
                              margin: EdgeInsets.only(top: 6),
                              height: 3,
                              width: 24,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(40)),
                                color:primary_,

                              ),
                            ) : const SizedBox(),
                          ],
                        ),

                      ),
                    ),
                    ),
                  ),
                }




          ],
        ),
      ),


    ),
    );
  }
}
