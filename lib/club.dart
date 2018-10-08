import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Club extends StatelessWidget {
  // This widget is the root of your application.
  final String name;
  final Map<dynamic, dynamic> data;
  Club(this.name, this.data);

  Widget homePage() {
    var te;
    data['Pictures'].forEach((key, val) {
      print(val);
      te = val;
    });
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[

Padding(padding: EdgeInsets.all(10.0),),
        RaisedButton( color:Colors.purple[50], onPressed: (){}, child:Text(
          name,
          style: TextStyle(
            fontSize: 40.0,color: Colors.blue[900],
          ),
        ),),
        Padding(padding: EdgeInsets.all(10.0),),

        Image.network(te),
        Container(
          child:Card(
          child:Text(data['Desc'],style:TextStyle(fontSize: 20.0)),
          color:Colors.blueGrey[50],),),
      ],
    ));
  }

  Widget eventsCard(var d) {
    return Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(
              d['heading'],
              style: new TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(d['description']),
          ),
           ButtonTheme.bar(
            // make buttons use the appropriate styles for cards
            child: new ButtonBar(
              children: <Widget>[
                new FlatButton(
                  child: Text(d['date']),
                  onPressed: () {},
                ),
                new FlatButton(
                  child: Text(d['time']),
                  onPressed: () {},
                ),
                new FlatButton(
                  child: Text(d['venue']),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget resourcesCard(d) {
    return Card(
      color: Colors.deepPurple[100],
      child: new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        ListTile(
          title: Text(
            d['heading'],
            style: new TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ButtonTheme.bar(
            child: new ButtonBar(children: <Widget>[
          FlatButton(
            color: Colors.deepPurple[200],
            child: Text(d['src']),
            onPressed: () async {
              if (await canLaunch(d['src'])) {
                await launch(d['src']);
              } else {
                throw 'Could not launch ${d['src']}';
              }
            },
          ),
        ]))
      ]),
    );
  }

  Widget resourcesPage() {
    List<Widget> temp = [];
    data['Res'].forEach((key, val) {
      temp.add(resourcesCard(val));
    });
    return ListView(children: temp);
  }

  Widget eventsPage() {
    List<Widget> temp = [];
    data['Events'].forEach((key, val) {
      temp.add(eventsCard(val));
    });
    return ListView(children: temp);
  }

  Widget announcementCard(var d) {
    return Card(
      color:Colors.blue[900],
      child:
        Padding(
          padding:EdgeInsets.all(10.0),
          child:Container(
            color:Colors.white,
            child:Column(children: <Widget>[
              Padding(padding:EdgeInsets.all(5.0)),
              Text(d['heading'],style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
                            Padding(padding:EdgeInsets.all(5.0)),

              Row(children: <Widget>[
                Padding(padding: EdgeInsets.all(10.0),),

                RaisedButton(child: Text('Time : '+d['time']),onPressed: (){},),
                Padding(padding: EdgeInsets.all(5.0),),
                RaisedButton(child:Text('Date : '+d['date']),onPressed: (){}),
              ],),
              Container(
                child:Text(d['announcement'],style:TextStyle(fontSize: 15.0)),

                padding: EdgeInsets.all(20.0),
            )],) 
          )
        ),);
  }

  Widget announcementPage() {
    List<Widget> te = [];
    data['Announcements'].forEach((key, value) {
      te.add(announcementCard(value));
    });
    return ListView(children: te);
  }

  Widget galleryPage() {
    List<Widget> temp = [];
    data['Pictures'].forEach((key, value) {
      temp.add(Image.network(value));
      temp.add(Container(color:Colors.black, padding:EdgeInsets.all(5.0),));
    });
    return ListView(
      children: temp,
    );
  }

  List<Widget> clubTabBar() {
    List<Widget> temp = [
      Tab(icon: Icon(Icons.home), text: "Home"),
      Tab(icon: Icon(Icons.alarm), text: "Events"),
      Tab(
        icon: Icon(Icons.book),
        text: "Resources",
      ),
      Tab(
        icon: Icon(Icons.directions_car),
        text: "Announcements",
      ),
      Tab(
        icon: Icon(Icons.hearing),
        text: "Gallery",
      ),
    ];
    return temp;
  }

  List<Widget> clubTabBarView() {
    List<Widget> temp = [];
    temp.add(homePage());
    temp.add(eventsPage());
    temp.add(resourcesPage());
    temp.add(announcementPage());
    temp.add(galleryPage());

    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: clubTabBar(),
            ),
            title: Text(name),
          ),
          body: TabBarView(
            children: clubTabBarView(),
          ),
        ),
      ),
    );
  }
}
