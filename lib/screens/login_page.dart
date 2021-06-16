import 'package:diagon_alley/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = '';
  bool changeButton = false;

  @override
  Widget build(BuildContext context) {
    return Material(
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
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Enter username', labelText: 'Username'),
                    onChanged: (value) {
                      name = value;
                      setState(() {});
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Enter password', labelText: 'Password'),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        changeButton = true;
                      });
                      await Future.delayed(Duration(seconds: 1));
                      Navigator.pushNamed(context, MyRoutes.homeRoute);
                    },
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      height: 50,
                      width: changeButton ? 50 : 100,
                      alignment: Alignment.center,
                      child: changeButton ? Icon(Icons.done, color: Colors.white,) : Text('Login', style: TextStyle(fontWeight: FontWeight.bold),),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(changeButton ? 50 : 10)
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
