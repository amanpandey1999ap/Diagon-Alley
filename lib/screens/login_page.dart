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

  String name = '';
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;

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
    return Material(
      color: context.canvasColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/images/login_image.png", fit: BoxFit.cover),
            SizedBox(height: 20),
            Text(
              'Welcome $name',
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
                          hintText: 'Enter username', labelText: 'Username'),
                      validator: (value){
                        if(value!.isEmpty){ return "Username must not be empty";}
                        return null;
                      },
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (value){
                        if (value!.isEmpty){ return "Password must not be empty";}
                        else if (value.length < 4){return "Password length should atleast be 4";}
                        return null;
                      } ,
                      decoration: InputDecoration(
                          hintText: 'Enter password', labelText: 'Password'),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(changeButton ? 50 : 10),
                      color: context.theme.buttonColor,
                      child: InkWell(
                        onTap: () async {
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: '+919650304181',
                            verificationCompleted: (PhoneAuthCredential credential) async {
                              await auth.signInWithCredential(credential);
                              goToHome(context);
                            },
                            verificationFailed: (FirebaseAuthException e) {},
                            codeSent: (String verificationId, int? resendToken) {
                              print("Code Sent");
                            },
                            codeAutoRetrievalTimeout: (String verificationId) {},
                          );
                        } ,
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          height: 50,
                          width: changeButton ? 50 : 100,
                          alignment: Alignment.center,
                          child: changeButton ? Icon(Icons.done, color: context.cardColor,) : Text('Login', style: TextStyle(color: context.cardColor, fontWeight: FontWeight.bold),),
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
