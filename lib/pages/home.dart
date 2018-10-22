import 'package:flutter/material.dart';
import 'package:gaurd/pages/phone_entry.dart';
import 'package:gaurd/pages/visitors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Sunshine Suvidha"),
      ),
      body: new ListView(
        padding: const EdgeInsets.all(30.0),
        
        children: <Widget>[
          new Container(
            child: new RaisedButton(
              child: new Text("ENTRY/ प्रवेश",style: new TextStyle(color: Colors.white,fontSize: 30.0),),
              onPressed: (){
                Navigator.of(context).push(new MaterialPageRoute(
                builder: ((BuildContext context){
                  return new Detail();
                })
              ));
              },
              color: new Color(0xFF5424eb),
              padding: EdgeInsets.fromLTRB(5.0, 30.0, 5.0, 30.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical( top: Radius.circular(3.0) , bottom: Radius.circular(3.0)) , side: BorderSide(color: Colors.black)),
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 50.0),),
          new Container(
            child: new RaisedButton(
              child: new Text("MESSAGES/ संदेश",style: new TextStyle(color: Colors.white,fontSize: 30.0),),
              onPressed: (){
                Navigator.of(context).push(new MaterialPageRoute(
                builder: ((BuildContext context){
                  return new Visitors();
                })
              ));
              },
              color: new Color(0xFF5424eb),
              padding: EdgeInsets.fromLTRB(5.0, 30.0, 5.0, 30.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical( top: Radius.circular(3.0) , bottom: Radius.circular(3.0)) , side: BorderSide(color: Colors.black)),
            ),
          ),
        ], 
      ),
    );
  }
}