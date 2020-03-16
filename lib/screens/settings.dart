import 'package:flutter/material.dart';
import 'package:myapp/screens/tags.dart';

class MySettings extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        child: MaterialButton(
          child: Text('Press'),
          onPressed: () {
          Navigator.push(context, 
            MaterialPageRoute(builder: 
              (context) => TagPage(),
            )
          );
          }
        )
      ),
    );
  }
}
