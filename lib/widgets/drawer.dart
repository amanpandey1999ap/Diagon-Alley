import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myImageUrl = "https://avatars.githubusercontent.com/u/53008904?v=4";
    return Drawer(
      child: Container(
        color: context.theme.primaryColor,
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage(myImageUrl)),
                    accountName: Text('Aman Pandey'),
                    accountEmail: Text('scarlettspeeedster@gmail.com')
                )
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.mail_outline),
              title: Text('Contact Us'),
              onTap: (){},
            )
          ],
        ),
      ),
    );
  }
}
