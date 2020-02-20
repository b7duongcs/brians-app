import'package:flutter/material.dart';
import 'package:myapp/inherited_widgets/inherited_widgets.dart';
import'screens/home.dart';
import'screens/reminders.dart';
import'screens/marks.dart';
import'screens/financials.dart';
import'screens/settings.dart';
import'inherited_widgets/inherited_widgets.dart';

class MyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return NoteInheritedWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Brian\'s app',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override 
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> pages = [
    HomePage(),
    RPage(),
    MPage(),
    FPage(),
  ];
  @override 
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('App Title'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => MySettings())
                );
              },
            )
          ],
        ),
        body: TabBarView(
          children: pages,
        ),
        bottomNavigationBar: new TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.home),
              //text: "Home",
            ),
            Tab(
              icon: Icon(Icons.calendar_today),
              //text: "Reminders",
            ),
            Tab(
              icon: Icon(Icons.check),
              //text: "Marks",
            ),
            Tab(
              icon: Icon(Icons.attach_money),
              //text: "Financials"
            ),
          ],
          labelColor: Colors.deepOrange,
          unselectedLabelColor: Colors.grey,
        ),
      )
    );
  }
}