import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AppSettings extends StatelessWidget {
  //const AppSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
            onTap: (){},
            borderRadius: BorderRadius.circular(10),
            child: Icon(Icons.settings, color: context.theme.accentColor, size: 30,)),
        SizedBox(),
      ],
    );
  }
}
