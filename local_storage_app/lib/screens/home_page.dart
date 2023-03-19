import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String storeKey;
  var storeValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Storage'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Key',
                  hintText: 'Enter Key',
                ),
                onChanged: (value) => storeKey = (value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Value',
                  hintText: 'Enter Value',
                ),
                onChanged: (value)  => storeValue = int.parse(value),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // ignore: deprecated_member_use
                MaterialButton(
                  child: Text('Read'),
                  onPressed: (){
                    _read();
                  },
                ),
                SizedBox(width: 20.0,),
                // ignore: deprecated_member_use
                MaterialButton(
                  child: Text('Save'),
                  onPressed: (){
                    _save();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = storeKey;
    final value = prefs.getInt(key) ?? 0;
    print('read : $value');
  }

  void _save() async{
    final prefs = await SharedPreferences.getInstance();
    final key = storeKey;
    final value = storeValue;
    prefs.setInt(key, value);
  }
}
