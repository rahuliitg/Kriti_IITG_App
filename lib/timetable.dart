import 'dart:async';
import 'dart:io' show Platform;
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class TimeTable extends StatefulWidget {
  TimeTable({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TimeTableState createState() => new _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  int _counter = 0;
  String prog;
  String dept;
  String sem;
  DatabaseReference _counterRef;
  var slotMap = {
    'A': {
      'Mon': [8, 9],
      'Tue': [9, 10],
      'Wed': [10, 11],
      'Thu': [11, 12],
      'Fri': [0, 0]
    },
    'B': {
      'Mon': [9, 10],
      'Tue': [10, 11],
      'Wed': [11, 12],
      'Thu': [0, 0],
      'Fri': [8, 9]
    },
    'C': {
      'Mon': [10, 11],
      'Tue': [11, 12],
      'Wed': [0, 0],
      'Thu': [8, 9],
      'Fri': [9, 10],
    },
    'D': {
      'Mon': [11, 12],
      'Tue': [0, 0],
      'Wed': [8, 9],
      'Thu': [9, 10],
      'Fri': [10, 11]
    },
    'E': {
      'Mon': [0, 0],
      'Tue': [8, 9],
      'Wed': [9, 10],
      'Thu': [10, 11],
      'Fri': [11, 12]
    },
    'F': {
      'Mon': [12, 13],
      'Tue': [0, 0],
      'Wed': [12, 13],
      'Thu': [0, 0],
      'Fri': [12, 13],
    },
    'ML1': {
      'Mon': [9, 12],
      'Tue': [0, 0],
      'Wed': [0, 0],
      'Thu': [0, 0],
      'Fri': [0, 0],
    },
    'ML2': {
      'Mon': [0, 0],
      'Tue': [9, 12],
      'Wed': [0, 0],
      'Thu': [0, 0],
      'Fri': [0, 0],
    },
    'ML3': {
      'Mon': [0, 0],
      'Tue': [0, 0],
      'Wed': [9, 12],
      'Thu': [0, 0],
      'Fri': [0, 0],
    },
    'ML4': {
      'Mon': [0, 0],
      'Tue': [0, 0],
      'Wed': [0, 0],
      'Thu': [9, 12],
      'Fri': [0, 0],
    },
    'ML5': {
      'Mon': [0, 0],
      'Tue': [0, 0],
      'Wed': [0, 0],
      'Thu': [0, 0],
      'Fri': [9, 12],
    },
    'AL1': {
      'Mon': [14, 17],
      'Tue': [0, 0],
      'Wed': [0, 0],
      'Thu': [0, 0],
      'Fri': [0, 0],
    },
    'AL2': {
      'Mon': [0, 0],
      'Tue': [14, 17],
      'Wed': [0, 0],
      'Thu': [0, 0],
      'Fri': [0, 0],
    },
    'AL3': {
      'Mon': [0, 0],
      'Tue': [0, 0],
      'Wed': [14, 17],
      'Thu': [0, 0],
      'Fri': [0, 0],
    },
    'AL4': {
      'Mon': [0, 0],
      'Tue': [0, 0],
      'Wed': [0, 0],
      'Thu': [14, 17],
      'Fri': [0, 0],
    },
    'AL5': {
      'Mon': [0, 0],
      'Tue': [0, 0],
      'Wed': [0, 0],
      'Thu': [0, 0],
      'Fri': [14, 17],
    },
    'A1': {
      'Mon': [17, 18],
      'Tue': [16, 17],
      'Wed': [15, 16],
      'Thu': [14, 15],
      'Fri': [0, 0],
    },
    'B1': {
      'Mon': [16, 17],
      'Tue': [15, 16],
      'Wed': [14, 15],
      'Thu': [0, 0],
      'Fri': [17, 18],
    },
    'C1': {
      'Mon': [15, 16],
      'Tue': [14, 15],
      'Wed': [0, 0],
      'Thu': [17, 18],
      'Fri': [16, 17],
    },
    'D1': {
      'Mon': [14, 15],
      'Tue': [0, 0],
      'Wed': [17, 18],
      'Thu': [16, 17],
      'Fri': [15, 16],
    },
    'E1': {
      'Mon': [0, 0],
      'Tue': [17, 18],
      'Wed': [16, 17],
      'Thu': [15, 16],
      'Fri': [14, 15],
    },
  };

  @override
  void initState() {
    super.initState();
    _counterRef =
        FirebaseDatabase.instance.reference().child('TimeTable').reference();
    dept = null;
    sem = null;
    prog = null;
  }

  List<String> deptList() {
    return <String>[
      'MA',
      'CSE',
      'BSBE',
      'CE',
      'CEN',
      'CH',
      'CL',
      'CRT',
      'DD',
      'EEE',
      'HSS',
      'ME',
      'PH'
    ];
  }

  List<String> progList() {
    return <String>['B.Tech.', 'M.Tech', 'PhD'];
  }

  List<String> semList() {
    return <String>['1', '3', '5', '7'];
  }
// remove tshis

  Widget timeTableCard(val, day) {
    return Card(
      
        color: Colors.white,
        child: Container(
          height: 50.0* (slotMap[val['slot']][day][1] - slotMap[val['slot']][day][0]),
          child:Row(
            children: <Widget>[
              ButtonTheme.bar(
                  // make buttons use the appropriate styles for cards
          child:ButtonBar(
                    alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(width: 20.0,color: Colors.purple[200],),
                    RaisedButton(
                        
                        onPressed: (){},
                        child: Text('${slotMap[val['slot']][day][0]}:00 - ${slotMap[val['slot']][day][1]}:00'),
                        textColor: Colors.black87,
                        ),Padding(padding: EdgeInsets.all(7.0),),
                      RaisedButton(
                          onPressed: (){},

                        child: Text(val['course'] + ',  Room No : ' + val['room']),
                        textColor: Colors.black87,
                      ),
                      ])),
        ])));
  }

  //dwsds
  Widget _getData(AsyncSnapshot snapshot, String day) {
    List<Widget> myList = [];
    var fi = new SplayTreeMap();
    if (snapshot.data.value != null)
      for (var value in snapshot.data.value.values) {
        print(value['slot']);
        if (value['slot'] != null && slotMap[value['slot']] != null) {
          var temp = slotMap[value['slot']][day][0];
          if (temp != 0) fi[temp] = value;
        }
      }

    fi.forEach((key, val) {
      day = day;
      print(key);
      myList.add(timeTableCard(val, day));
      myList.add(Padding(padding: EdgeInsets.all(10.0),));
    });
    return Column(
      children: myList,
    );
  }

  Widget createTable(String day, String path) {
    if (dept == null || sem == null || prog == null)
      return Column(
        children: <Widget>[
          Text("Select" + day),
          dropDownMenu(),
        ],
      );

    return FutureBuilder(
        future: _counterRef.child(path).reference().once(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot.data);
          print(dept + '/' + prog[0] + '/' + sem);
          if (snapshot.data != null) {
            print("comming here");
            return _getData(snapshot, day);
          } else {
            print("comming thhhhhhh");
            return Text("Getting Data");
          }
        });
  }

  Widget dropDownItem(List<String> list, String type, i) {
    return Expanded(
        child: DropdownButton<String>(
          elevation: 8,
          hint: Text(type),
          items: list.map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          value: (i == 0) ? dept : (i == 1) ? prog : sem,
          onChanged: (String val) {
            setState(() {
              if (i == 0)
                dept = val;
              else if (i == 1)
                prog = val;
              else
                sem = val;
            });
          },
        ));
  }

  Widget dropDownMenu() {
    return Row(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
                Padding(padding: EdgeInsets.all(5.0),),

        dropDownItem(deptList(), "Department", 0),
                Padding(padding: EdgeInsets.all(5.0),),

        dropDownItem(progList(), "Program ", 1),
                Padding(padding: EdgeInsets.all(5.0),),

        dropDownItem(semList(), "Semester", 2),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(text: "Monday"),
                  Tab(text: "Tuesday"),
                  Tab(text: "Wednesday"),
                  Tab(text: "Thursday"),
                  Tab(text: "Friday"),
                ],
              ),
              title: Text("Time Table"),
            ),
            body: TabBarView(children: <Widget>[
              (dept == null || sem == null || prog == null)
                  ? dropDownMenu()
                  : createTable("Mon", dept + '/' + prog[0] + '/' + sem),
              (dept == null || sem == null || prog == null)
                  ? dropDownMenu()
                  : createTable("Tue", dept + '/' + prog[0] + '/' + sem),
              (dept == null || sem == null || prog == null)
                  ? dropDownMenu()
                  : createTable("Wed", dept + '/' + prog[0] + '/' + sem),
              (dept == null || sem == null || prog == null)
                  ? dropDownMenu()
                  : createTable("Thu", dept + '/' + prog[0] + '/' + sem),
              (dept == null || sem == null || prog == null)
                  ? dropDownMenu()
                  : createTable("Fri", dept + '/' + prog[0] + '/' + sem),
            ])));
  }
}
