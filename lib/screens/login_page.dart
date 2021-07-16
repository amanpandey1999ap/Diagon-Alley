import 'package:diagon_alley/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String phoneNo = '';
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();
  int codeSent = 0;
  String loginButton = 'Send Code';
  bool otpField = false;
  String otp = '';
  String verifyId = '';

  FirebaseAuth auth = FirebaseAuth.instance;



  bool enterCode = false;

  goToHome(BuildContext context) async{
    if(_formKey.currentState!.validate()){
      setState(()=> changeButton = true);
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoutes.homeRoute);
      setState(()=> changeButton = false);
    }
  }

  @override
  Widget build(BuildContext context) {

    auth.authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        goToHome(context);
      }
    });

    return Material(
      color: context.canvasColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/images/login_image.png", fit: BoxFit.cover),
            SizedBox(height: 20),
            Text(
              'Welcome $phoneNo',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Enter Phone Number', labelText: 'Phone Number'),
                      validator: (value){
                        if(value!.isEmpty){ return "Phone Number must not be empty";}
                        return null;
                      },
                      onChanged: (value) {
                        phoneNo = value;
                        setState(() {});
                      },
                    ),
                    Visibility(
                      visible: otpField,
                      child: TextFormField(
                        obscureText: true,
                        validator: (value){
                          otp = value!;
                          if (value.isEmpty){ return "OTP must not be empty";}
                          else if (value.length < 6){return "Password length should atleast be 6";}
                          return null;
                        } ,
                        decoration: InputDecoration(
                            hintText: 'Enter OTP', labelText: 'OTP'),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(changeButton ? 50 : 10),
                      color: context.theme.buttonColor,
                      child: InkWell(
                        onTap: () async {

                          if(enterCode == false){
                            await FirebaseAuth.instance.verifyPhoneNumber(
                                phoneNumber: '+91$phoneNo',


                                verificationCompleted: (PhoneAuthCredential credential) async {
                              setState(() {
                                otp = credential.smsCode!;
                              });
                              await auth.signInWithCredential(credential);
                              // if(auth.currentUser != null){
                              //   goToHome(context);
                              // }
                            },


                          verificationFailed: (FirebaseAuthException e) {},


                          codeSent: (String verificationId, int? resendToken) {
                          verifyId = verificationId;
                          enterCode = true;
                          setState(() {
                          loginButton = 'Login';
                          otpField = true;

                          });
                          print("Code Sent");
                          },


                          codeAutoRetrievalTimeout: (String verificationId) {},


                            );
                          }

                          else{
                            auth.signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: verifyId,
                                smsCode: otp
                              )
                            );
                            // if(auth.currentUser != null){
                            //   goToHome(context);
                            // }
                          }

                        } ,
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          height: 50,
                          width: changeButton ? 50 : 100,
                          alignment: Alignment.center,
                          child: changeButton ? Icon(Icons.done, color: context.cardColor,) : Text(loginButton, style: TextStyle(color: context.cardColor, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
