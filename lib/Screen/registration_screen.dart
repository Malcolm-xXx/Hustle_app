import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final nameTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final phoneTextEditingController = TextEditingController();
  final addressTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmTextEditingController = TextEditingController();

  bool _passwordVisible = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool darkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Column(children: [
              Image.asset(
                  darkTheme ? 'images/dsignup.jpeg' : 'images/signup.jpeg'),

              SizedBox(height: 20),

              Text(
                'Sign Up',
                style: TextStyle(
                  color: darkTheme ? Colors.amber.shade400 : Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50),
                            ],
                            decoration: InputDecoration(
                              hintText: 'Name',
                              hintStyle: TextStyle(
                                color: Colors.grey
                              ),
                              filled: true,
                              fillColor: darkTheme ? Colors.black45 :Colors.grey.shade200,
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
                                return"Name can\'t be empty";
                              }
                              if (text.length < 2){
                                return"please enter a valid name";
                              }
                              if (text.length > 49){
                                return"Name can\'t be more than 50 ";
                              }
                            },
                            onChanged: (text) => setState(() {
                              nameTextEditingController.text = text;
                            }),
                          ),

                          SizedBox(height: 10,),

                          TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(100),
                            ],
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                  color: Colors.grey
                              ),
                              filled: true,
                              fillColor: darkTheme ? Colors.black45 :Colors.grey.shade200,
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
                          ),

                          SizedBox(height: 10,),

                          IntlPhoneField(
                            showCountryFlag: true,
                            dropdownIcon: Icon(
                              Icons.arrow_drop_down,
                              color: darkTheme? Colors.amber.shade400 : Colors.grey,
                            ),
                            decoration: InputDecoration(
                            hintText: 'Phone',
                            hintStyle: TextStyle(
                                color: Colors.grey
                            ),
                            filled: true,
                            fillColor: darkTheme ? Colors.black45 :Colors.grey.shade200,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                            initialCountryCode: 'NG',
                            onChanged: (text) => setState(() {
                              phoneTextEditingController.text = text.completeNumber;
                            }),
                          ),

                          SizedBox(height: 10,),

                          TextFormField(
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
                              fillColor: darkTheme ? Colors.black45 :Colors.grey.shade200,
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
                          ),

                          SizedBox(height: 10,),

                          TextFormField(
                            obscureText: !_passwordVisible,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50),
                            ],
                            decoration: InputDecoration(
                              hintText: 'Confirm password',
                              hintStyle: TextStyle(
                                  color: Colors.grey
                              ),
                              filled: true,
                              fillColor: darkTheme ? Colors.black45 :Colors.grey.shade200,
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
                                return"Confirm password can\'t be empty";
                              }
                              if (text != passwordTextEditingController.text){
                                return"password do not match";
                              }
                              if (text.length < 2){
                                return"Confirm password enter a valid name";
                              }
                              if (text.length > 49){
                                return"Confirm password can\'t be more than 50 ";
                              }
                              return null;
                            },
                            onChanged: (text) => setState(() {
                              confirmTextEditingController.text = text;
                            }),
                          ),

                          SizedBox(height: 20,),



                        ],
                      ),
                    ),
                  ],
                ),
              ),
             ],
            ),
          ],
        ),
      ),
    );
  }
}
