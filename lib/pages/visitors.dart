import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Visitors extends StatefulWidget {
  @override
  _VisitorsState createState() => _VisitorsState();
}

class _VisitorsState extends State<Visitors> {
  CollectionReference collectionReference = Firestore.instance.collection("society").document("sunshine").collection("notification");
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Visitors"),
        centerTitle: true,
      ),
      body: new Container(
        child: new StreamBuilder<QuerySnapshot>(
          stream: collectionReference.snapshots(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
           return Center(
             child: new CircularProgressIndicator(),
           );
          }
          final int count = snapshot.data.documents.length;
          snapshot.data.documents.reversed;
          if(count==0){
            return new Center(
              child: new Text("NO RESULT FOUND",style: TextStyle(color: Colors.red,fontSize: 20.0),),
            );
          }else {
            return new ListView.builder(
              itemCount: count,
              itemBuilder: (_,index){
                final DocumentSnapshot document = snapshot.data.documents[index];

                return new Container(
                child: new Card(
                  child: new ListTile(
                    title: new Text("${document['name']}\t${document['time']}"),
                    subtitle: new Text("${document['message']}\n${document['mobile']}\n${document['address']}"),
                    onTap: (){
                      
                    },
                  ),
                ),
              );

              }
            );
          }
          }
        ),
      ),
    );
  }
}
