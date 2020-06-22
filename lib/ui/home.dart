import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _enterData= TextEditingController();
  String _savedData="";

  //for sharewd preferences start with an init declaration then create the
  //loadSavedData function
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadSavedData();
  }

  _saveMessage(String message) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("data", message);
  }
  _loadSavedData() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      if(preferences.getString("data")!= null && preferences.getString("data").isNotEmpty) {
        _savedData = preferences.getString("data");
      }else{
        _savedData="";
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Preferences"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: new Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.topCenter,
        child: ListTile(
            title: TextField(
              controller: _enterData,
              decoration: InputDecoration(labelText: "write data"),
            ),
            subtitle: FlatButton(
              onPressed: () {
                //save data
                _saveMessage(_enterData.text);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text("Save data"),
                        Padding(padding: EdgeInsets.all(8.0)),
                        Text(_savedData)
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
