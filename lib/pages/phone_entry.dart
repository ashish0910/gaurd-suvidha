import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

var phonecontroller = new TextEditingController();
String vname;
class _DetailState extends State<Detail> {
  final formKey = new GlobalKey<FormState>();
  String _name,_housenumber,_purpose,_error;
  bool load = false ;
  bool found=false ;
  DocumentReference documentReference ;
  bool phone_exist_check(){
    documentReference = Firestore.instance.collection("society").document("sunshine").collection("visitor").document("${phonecontroller.text.toString()}");
    String name;
    documentReference.get().then((snapshot){
      if(snapshot.exists){
        name=snapshot['name'];
      }
    }).whenComplete((){
      // print(name); 
      vname=name;
      found=true;
      load=false;
      // print(load);
      setState(() {});
      return true;
    });
    if(name==null){
      // print("number not found");
      return false;

    }
  }

  bool phone_check(){
    if(phonecontroller.text.toString().length==10){
      // print("it is 10 now");
      return true;
    }else{
      // print("not 10");
      return false;
    }
  }

  bool _validate(){
    final form  = formKey.currentState;
    if(form.validate()){
      form.save();
      return true ;
    } else {
      return false ;
    }
  }

  void submit() async{
    DateTime dateTime = DateTime.now();
    if(_validate()){
      try {
        print("$_name  $_housenumber $_purpose ${phonecontroller.text.toString()}");
        Map<String,dynamic> data = <String,dynamic> {
          "name" : _name ,
          "housenumber" : _housenumber,
          "purpose" : _purpose,
          "mobile" : phonecontroller.text.toString(),
          "time" : dateTime
        };
        documentReference = Firestore.instance.collection("society").document("sunshine").collection("visitor").document("${phonecontroller.text.toString()}");
        documentReference.setData(data).whenComplete((){
          print("registerd");
          Navigator.of(context).pop();
        }); 
      }
      catch(e){
        print(_error);
        setState(() {
                  _error="Some problem" ;
                });
      }
    }
  }

    File img;
    Future picker(int c,String s) async{
    print("picker called");
    setState(() {});
    var _img;
    if(c==1){
      _img = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    else if(c==2){
      _img = await ImagePicker.pickImage(source: ImageSource.camera);
    }
  
    if(_img!=null){      
      img=_img;
      print("image adder called");
      imageadder(s);
    }

  }
  String location;
  void imageadder(String s) async{
    String phoneno = phonecontroller.text.toString();
    var ref=FirebaseStorage.instance.ref();
    print("${img.path} $phoneno");
    ref.child("${phoneno}.jpg").putFile(img);
    if(ref.child("${phoneno}.jpg").putFile(img).isComplete){
      print("success");
    }
    
    // location = await ref.getDownloadURL();
    // print(location);
    setState(() {});
  }

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      phonecontroller.clear();
      const oneSec = const Duration(seconds:4);
      new Timer.periodic(oneSec, (Timer t){
        if(phone_check()==true){
          load = true;
          setState(() {});
          phone_exist_check();
          // print(load);
          // if(phone_exist_check()==true){
          //   print("number found");
          //   t.cancel();
          // }
          // if(found==true){
          //   phonecontroller.addListener((){
          //     print("listner call");
              
          //   });
          // }
        }
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Enter Details"),
      ),
      body: new ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          
          new TextField(
           keyboardType: TextInputType.number,
           decoration: InputDecoration(
           labelText: "Phone Number",
            hintText: "Enter 10 digit phone number",             
            ),
            // onEditingComplete: (){
            //   print("edit complete");
            // },
            onChanged: (String s){
              print("text changed");
              if(found==true){
                found=false;
              }
            }, 
            maxLength: 10,
            controller: phonecontroller,
          ),
          (load==true&&found==false) ? 
          new Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: LinearProgressIndicator(),
          ) : new Container(),
          new Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
          vname!=null ? new Container(
            child: new MaterialButton(
              child: new Column(
                children: <Widget>[
                  Text("$vname",style: TextStyle(color: Colors.white,fontSize: 20.0),),
                  Text("Tap to Allow/ अनुमति दे",style: TextStyle(color: Colors.white,fontSize: 20.0))
                ],
              ),
              padding: EdgeInsets.all(10.0),
              color: new Color(0xFF5424eb),
              onPressed: (){},
            )
          ) : new Container(
            child: Form(
                key: formKey,
                child: new Column(
                children: <Widget>[
              new IconButton(
              padding: EdgeInsets.only(right: 45.0),
              icon: Icon(Icons.photo_camera,size: 100.0,),
              onPressed: (){
                picker(2, "photo");
              },
              ),
              new Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                ),
              new TextFormField(
                decoration: new InputDecoration(
                  hintText: "eg. F0212",
                  labelText: "House number/ घर का नंबर"
                ),
                validator: (value) => value.isEmpty ? 'Please Enter House number' : null,
                onSaved: (value) => _housenumber=value,
              ),
              new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                new TextFormField(
                decoration: new InputDecoration(
                  hintText: "Enter name",
                  labelText: "Name / नाम"
                ),
                validator: (value) => value.isEmpty ? 'Please Enter name' : null,
                onSaved: (value) => _name=value,
              ),
              new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                new TextFormField(
                decoration: new InputDecoration(
                  hintText: "Enter Purpose of visit",
                  labelText: "purpose / उद्देश्य"
                ),
                validator: (value) => value.isEmpty ? 'Please Enter purpose' : null,
                onSaved: (value) => _purpose=value,
              ),
              new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
              new MaterialButton(
                  child: Text("Tap to Allow/ अनुमति दे",style: TextStyle(color: Colors.white,fontSize: 20.0)),
                  onPressed: (){
                    submit();
                  },
                  color: new Color(0xFF5424eb),
                ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
