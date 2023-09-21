import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:hustle/FadeAnimation.dart';
import 'package:hustle/Global/global.dart';
import 'package:hustle/Screen/main_screen.dart';
import 'package:hustle/Screen/login_screen.dart';



class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  final emailTextEditingController = TextEditingController();



  final _formKey = GlobalKey<FormState>();

  void _submit() {
    firebaseAuth.sendPasswordResetEmail(
        email: emailTextEditingController.text.trim()
    ).then((value){
      Fluttertoast.showToast(msg: "we have sent you an email to recover password, please check email");
    }).onError((error, stackTrace){
      Fluttertoast.showToast(msg: "Error occured: \n ${error.toString()}");
    });

  }

  @override
  Widget build(BuildContext context) {
    bool darkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.yellow]
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80,),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FadeAnimation(1, Text("Hustler", style: TextStyle(fontFamily:'font1' , color: Colors.amber.shade400, fontSize: 50),)),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    FadeAnimation(1, Text("Forget password", style: TextStyle(color: darkTheme ? Colors.black : Colors.white, fontSize: 40),)),

                    SizedBox(height: 10,),

                    FadeAnimation(1.3, Text("Don\'t get signed out", style: TextStyle(color: darkTheme ? Colors.black : Colors.white, fontSize: 18),)),
                  ],
                ),
              ),//sign in text
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: darkTheme ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 10,),

                                FadeAnimation(2.5,TextFormField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(100),
                                  ],
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                        color: Colors.grey
                                    ),
                                    filled: true,
                                    fillColor: darkTheme ? Colors.grey.shade900 :Colors.grey.shade200,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    prefixIcon: Icon(Icons.person,color: darkTheme ? Colors.amber.shade400 : Colors.grey,),
                                  ),
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (text) {
                                    if (text==null || text.isEmpty){
                                      return"Email can\'t be empty";
                                    }
                                    if (EmailValidator.validate(text)== true){
                                      return null ;
                                    }
                                    if (text.length < 2){
                                      return"please enter a valid Email";
                                    }
                                    if (text.length > 99){
                                      return"Email can\'t be more than 100 ";
                                    }
                                  },
                                  onChanged: (text) => setState(() {
                                    emailTextEditingController.text = text;
                                  }),
                                )),//emai

                                SizedBox(height: 20,),

                                ElevatedButton(
                                  onPressed: () {
                                    _submit();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.amber.shade400,
                                    onPrimary: darkTheme? Colors.black : Colors.white,
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    minimumSize: Size(double.infinity, 50),
                                  ),

                                  child: Text (
                                    "Reset Password",
                                    style: TextStyle(
                                      fontSize: 20,

                                    ),
                                  ) ,
                                ),// reset button


                                SizedBox(height: 20,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account ?",
                                      style: TextStyle(
                                        color: darkTheme? Colors.amber.shade400 : Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),

                                    SizedBox(width: 5,),

                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (c) => LoginScreen()));
                                      },
                                      child: Text(
                                        " Login",
                                        style: TextStyle(
                                          color: Colors.amber.shade400,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),

                                  ],
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )//form
            ],
          ),
        ),

      ),
    );
  }
}
