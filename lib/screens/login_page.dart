import 'package:diagon_alley/screens/home_page.dart';
import 'package:diagon_alley/services/authservice.dart';
import 'package:diagon_alley/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();
  String loginButton = 'Send Code';
  bool showOtpField = false;
  var otp = '';

  final FirebaseAuth auth = FirebaseAuth.instance;

  late String phoneNo, smssent, verificationId;

  get verifiedSuccess => null;
  bool codeSent = false;

  // Future<void> verfiyPhone() async {
  //   final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
  //     this.verificationId = verId;
  //   };
  //   final PhoneCodeSent smsCodeSent = (String verId, [int? forceCodeResent]) {
  //     showOtpField = true;
  //     this.verificationId = verId;
  //     smsCodeDialoge(context).then((value) {
  //       loginButton = 'Login';
  //       print("Code Sent");
  //     });
  //   };
  //   final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {
  //     print("Hi Hello kuch bhi phone verification completed");
  //     //goToHome(context);
  //   };
  //   await auth.verifyPhoneNumber(
  //     phoneNumber: phoneNo,
  //     timeout: const Duration(seconds: 60),
  //     verificationCompleted: verifiedSuccess,
  //     codeSent: smsCodeSent,
  //     codeAutoRetrievalTimeout: autoRetrieve,
  //     verificationFailed: (FirebaseAuthException error) {
  //       print("Error : $error");
  //     },
  //   );
  // }

  // Future<void> verifyPhone() async {
  //   final PhoneVerificationCompleted verified = (AuthCredential authResult) {};
  //
  //   final PhoneCodeSent smsSent = (String verId, [int? forceResend]) {
  //     showOtpField = true;
  //     this.verificationId = verId;
  //     smsCodeDialoge(context).then((value) {
  //       loginButton = 'Login';
  //       print("Code Sent");
  //     });
  //   };
  //
  //   final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
  //     this.verificationId = verId;
  //   };
  //
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: phoneNo,
  //       timeout: const Duration(seconds: 60),
  //       verificationCompleted: verified,
  //       verificationFailed: (FirebaseAuthException error) {
  //         print("Error : $error");
  //       },
  //       codeSent: smsSent,
  //       codeAutoRetrievalTimeout: autoTimeout);
  // }
  //
  // Future<dynamic> smsCodeDialoge(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return new AlertDialog(
  //           title: Text('Enter OTP'),
  //           content: TextField(
  //             onChanged: (value) {
  //               if (value.isNotEmpty && value.length == 6) {
  //                 this.smssent = value;
  //                 print(" Value sahi hai madarchoxxxx ");
  //               }
  //             },
  //           ),
  //           contentPadding: EdgeInsets.all(10.0),
  //           actions: <Widget>[
  //             FlatButton(
  //               onPressed: () {
  //                 if (auth.currentUser != null) {
  //                   signIn(smssent);
  //                   print("auth null nhi hai");
  //                   Navigator.of(context).pop();
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(builder: (context) => LoginPage()),
  //                   );
  //                 } else {
  //                   print("auth null hi hai");
  //                   Navigator.of(context).pop();
  //                 }
  //               },
  //               child: Text(
  //                 'done',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //             ),
  //           ],
  //         );
  //       });
  // }
  //
  // Future<void> signIn(String smsCode) async {
  //   final AuthCredential credential = PhoneAuthProvider.credential(
  //     verificationId: verificationId,
  //     smsCode: smsCode,
  //   );
  //
  //   auth.signInWithCredential(credential).then((user) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => HomePage(),
  //       ),
  //     );
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  goToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() => changeButton = true);
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoutes.homeRoute);
      setState(() => changeButton = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // auth.authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     print('User is currently signed out!');
    //   } else {
    //     print('User is signed in!');
    //     goToHome(context);
    //   }
    // });

    return Material(
      color: context.canvasColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/images/login_image.png", fit: BoxFit.cover),
            SizedBox(height: 20),
            Text(
              'Welcome',
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
                          hintText: 'Enter Phone Number',
                          labelText: 'Phone Number'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Phone Number must not be empty";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        phoneNo = '+91$value';
                        setState(() {});
                      },
                    ),


                    Visibility(
                      visible: showOtpField,
                      child: TextFormField(
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            this.smssent = value;
                          });
                        },
                        // validator: (value){
                        //    this.smssent = value!;
                        //  // if (otp.isEmpty){ return "OTP must not be empty";}
                        //    // else if (otp.length == 6){return "Password length must be 6";}
                        //   return null;
                        // } ,
                        decoration: InputDecoration(
                            hintText: 'Enter OTP', labelText: 'OTP'),
                      ),
                    ),


                    SizedBox(
                      height: 40,
                    ),
                    Material(
                      borderRadius:
                          BorderRadius.circular(changeButton ? 50 : 10),
                      color: context.theme.buttonColor,
                      child: InkWell(
                        onTap: () {
                         // verifyPhone(phoneNo);
                          codeSent ? AuthService().signInWithOTP(smssent, verificationId):verifyPhone(phoneNo);
                        },
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          height: 50,
                          width: changeButton ? 50 : 100,
                          alignment: Alignment.center,
                          child: changeButton
                              ? Icon(
                                  Icons.done,
                                  color: context.cardColor,
                                )
                              : Text(
                                  loginButton,
                                  style: TextStyle(
                                      color: context.cardColor,
                                      fontWeight: FontWeight.bold),
                                ),
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

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int? forceResend]) {
      showOtpField = true;
      loginButton = 'Submit OTP';
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
