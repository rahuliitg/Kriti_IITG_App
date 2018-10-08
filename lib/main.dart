import 'dart:async';
import 'dart:io' show Platform;
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'club.dart';
import 'timetable.dart';

Future<void> main() async {
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'db2',
    options: const FirebaseOptions(
      googleAppID: '1:449573222649:android:3bda94c9cc3bd5e2',
      apiKey: 'AIzaSyBKpkIggXwQujW_9M7v01tVH-UyWN9CbcA',
      databaseURL: 'https://hackriti-110f1.firebaseio.com',
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: 'IIT Guwahati Dashboard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseReference _counterRef;
  @override
  void initState() {
    super.initState();
    _counterRef = FirebaseDatabase.instance.reference();
  }

  List<Widget> drawerChildren() {
    List<Widget> temp = [
      DrawerHeader(
      padding: EdgeInsets.fromLTRB(1.0, 5.0, 1.0, 10.0),
        child: Row(
          children: <Widget>[
            Icon(Icons.blur_on,size:40.0,color: Colors.white,),
            Text('  DashBoard',style: TextStyle(fontSize: 30.0,color: Colors.white)),
            ],
          ), 
        decoration: BoxDecoration(
          color: Colors.purple,
        ),
      ),
    ];
    _counterRef.child('clubs').reference().once().then(
      (DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        print("basic");
        values.forEach((key, val) {
          temp.add(ListTile(
            title: Text(key),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Club(key, val)),
              );
            },
          ));
        });
      },
    );

    temp.add(ListTile(
        title: Text('TimeTable'),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TimeTable()),
          );
        }));
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: drawerChildren(),
        ),
      ),
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: ListView(
          children:<Widget>[
            Image.network("https://i2.wp.com/www.noticebard.com/wp-content/uploads/2017/12/IIT-Guwahati.jpg?fit=1280%2C720&ssl=1") ,
            Padding(padding: EdgeInsets.all(20.0),),
            Text("IIT-Guwahati is ranked 14th among 20 institutions classed as the world'sbest small universities in the latest Times Higher Education (THE) rankings 2",
    style: TextStyle(fontSize: 18.0,fontStyle: FontStyle.italic,letterSpacing: 2.0,)),
           Padding(padding: EdgeInsets.all(20.0),),
Image.network('http://iitg.ac.in/freshers/res/images/Guesthouse.JPG'),
          ]))
      
    );
  }
}
