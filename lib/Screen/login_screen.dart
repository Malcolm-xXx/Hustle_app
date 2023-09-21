import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:hustle/FadeAnimation.dart';
import 'package:hustle/Global/global.dart';
import 'package:hustle/Screen/main_screen.dart';
import 'package:hustle/Screen/forgot_password_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();

  bool _passwordVisible = false;

  final _formKey = GlobalKey<FormState>();

  void _submit() async{
    if(_formKey.currentState!.validate()) {
      await firebaseAuth.signInWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
      ).then((auth) async {
        currentUser = auth.user;


        await Fluttertoast.showToast(msg: "Successfully logged in");
        Navigator.push(context, MaterialPageRoute(builder: (c) => MainScreen()));
      }).catchError((errorMessage) {
        Fluttertoast.showToast(msg: "Error occured \n $errorMessage");
      });
    }

    else{
      Fluttertoast.showToast(msg: "Not all feild are valid");
    }

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

                    FadeAnimation(1, Text("Login", style: TextStyle(color: darkTheme ? Colors.black : Colors.white, fontSize: 40),)),

                    SizedBox(height: 10,),

                    FadeAnimation(1.3, Text("Welcome back", style: TextStyle(color: darkTheme ? Colors.black : Colors.white, fontSize: 18),)),
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

                                FadeAnimation(2.7,TextFormField(
                                  obscureText: !_passwordVisible,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(50),
                                  ],
                                  decoration: InputDecoration(
                                    hintText: 'Password',
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
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                        color: darkTheme? Colors.amber.shade400 : Colors.grey,
                                      ),
                                      onPressed: () => setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      }),
                                    ),
                                  ),
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (text) {
                                    if (text==null || text.isEmpty){
                                      return"Password can\'t be empty";
                                    }
                                    if (text.length < 2){
                                      return"Password enter a valid name";
                                    }
                                    if (text.length > 49){
                                      return"Password can\'t be more than 50 ";
                                    }
                                    return null;
                                  },
                                  onChanged: (text) => setState(() {
                                    passwordTextEditingController.text = text;
                                  }),
                                )),//password

                                SizedBox(height: 10,),


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
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 20,

                                    ),
                                  ) ,
                                ),// registration button

                                SizedBox(height: 20,),

                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (c) => ForgetPasswordScreen()));
                                  },
                                  child: Text(
                                    "Forgot password ?",
                                    style: TextStyle(
                                        color: Colors.amber.shade400
                                    ),
                                  ),
                                ),//forget password

                                SizedBox(height: 20,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Does not have an account ?",
                                      style: TextStyle(
                                        color: darkTheme? Colors.amber.shade400 : Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),

                                    SizedBox(width: 5,),

                                    GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        " Sign up",
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
