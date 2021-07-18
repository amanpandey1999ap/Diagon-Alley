import 'package:diagon_alley/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutTile extends StatefulWidget {
  //const LogoutTile({Key? key}) : super(key: key);

  @override
  _LogoutTileState createState() => _LogoutTileState();
}

class _LogoutTileState extends State<LogoutTile> {

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.logout),
      title: Text('Logout'),
      onTap: (){
        _logout();
      },
    );
  }
}
