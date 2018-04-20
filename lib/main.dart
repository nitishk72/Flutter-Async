import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
main(){
  runApp(new AppName());
}

class AppName extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new AppState();
  }
}

class AppState extends State<AppName>{
  String name = '';
  int id = 0;
  int public_repos = 0;
  TextEditingController user = new TextEditingController();
  String url = 'https://api.github.com/users/';

  getData(String username) async{
    String profile = url+username;
    var res = await http.get(profile,headers: {"Accept":"application/json"});
    var resBody = json.decode(res.body);
    name = resBody['name'];
    id = resBody['id'];
    public_repos = resBody['public_repos'];
    setState(() {
      print("Success");
    });
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar:  AppBar(
          title: new Text("JSON App"),
        ),
        body: new Container(
          padding: EdgeInsets.all(12.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Padding(padding: EdgeInsets.only(bottom: 10.0)),
              new TextField(
                controller: user,
                decoration: InputDecoration(hintText: "Enter Github Uername"),
              ),
              new Padding(padding: EdgeInsets.only(bottom: 10.0)),
              new RaisedButton(
                  onPressed: ()=>getData(user.text),
                  child: new Text("Get Info")
              ),
              new Padding(padding: EdgeInsets.only(bottom: 20.0)),
              new Text("ID : $id",style: TextStyle(fontSize: 20.0),),
              new Padding(padding: EdgeInsets.only(bottom: 10.0)),
              new Text("Name : $name",style: TextStyle(fontSize: 22.0),),
              new Padding(padding: EdgeInsets.only(bottom: 10.0)),
              new Text("Public repo : $public_repos",style: TextStyle(fontSize: 20.0),),
            ],
          ),
        ),
      ),
    );
  }
}