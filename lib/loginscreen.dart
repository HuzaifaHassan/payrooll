    import 'package:cloud_firestore/cloud_firestore.dart';
    import 'package:flutter/material.dart';
    import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

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
        final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(context);


        screenHeight_ = MediaQuery
            .of(context)
            .size
            .height;
        screenWidth_ = MediaQuery
            .of(context)
            .size
            .width;


        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              isKeyboardVisible ? const SizedBox()  : Container(
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
                    customField("Enter Password", passwordController_,isPassword: true),
                    GestureDetector(
                      onTap:  () async{
                        FocusScope.of(context).unfocus();
                        String id = idController_.text.trim();
                        String password = passwordController_.text.trim();

                        if(id.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please Enter Employee ID"),
                            ));

                        }else if(password.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please Enter Password"),
                            ));
                        }else{
                          QuerySnapshot snap_= await FirebaseFirestore.
                          instance.collection("Employee").where('id',isEqualTo: id).get();

                          try{
                            final snap = await FirebaseFirestore.instance
                                .collection("Employee")
                                .where('id', isEqualTo: id)
                                .get();
                            if(password==snap_.docs[0]['password']){
                              print("continue");
                            }

                             else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Incorrect password")), // ✅ should show now
                              );
                              print("Wrong password entered");
                            }

                          }
                          catch(e){
                            String error=" ";

                            if(e.toString()=="Invalid value: Valid value range is empty: 0"){
                                 setState(() {
                                   error="Employee id does not exist";
                                 });
                            }
                            else{
                              setState(() {
                                error="Error occurred!";
                              });
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(content: Text(error)), // ✅ should show now
                            );
                          }
                        }

                        },

                      child: Container(
                        height: 60,
                        width: screenWidth_,
                        margin: EdgeInsets.only(
                          top: screenHeight_ / 40,
                        ),
                        decoration: BoxDecoration(color: primary_,
                        borderRadius: const BorderRadius.all( Radius.circular(30)),

                        ),
                        child: Center(
                          child: Text("LOGIN",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth_ / 26,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),

                        ),
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
      Widget customField(String hint, TextEditingController controller, {bool isPassword = false}) {
        bool _obscureText = isPassword; // Start obscured if it's a password field

        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              width: screenWidth_,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: screenWidth_ / 6,
                    child: Icon(
                      isPassword ? Icons.lock : Icons.person, // 👈 Lock icon for password
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
                        obscureText: _obscureText, // 👈 hides text with bullets
                        obscuringCharacter: '•',   // 👈 bullet character
                        decoration: InputDecoration(
                          hintText: hint,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: screenHeight_ / 35,
                          ),
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: screenWidth_ / 26,
                          ),
                          // 👇 Add eye icon for password toggle
                          suffixIcon: isPassword
                              ? IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: primary_,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          )
                              : null,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }

    }