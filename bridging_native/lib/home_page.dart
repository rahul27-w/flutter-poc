import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const CHANNEL = "Native Channel";
  static const platform = const MethodChannel(CHANNEL);

  String _responseFromNativeCode = 'Waiting for Response...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter To Android"),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: TextButton(
                  child: Text('Switch To Native'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.teal,
                    onSurface: Colors.grey,
                  ),
                  onPressed: () {
                    _showNativeScreen();
                    print('Pressed');
                  },
                ),
              ),
              Text(_responseFromNativeCode, style: TextStyle(
                fontSize: 18,
              ),),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showNativeScreen() async{
    String response = "";
    try{
      final String result = await platform.invokeMethod("KEY_NATIVE");
      response = result;
    } on PlatformException catch (e) {
      response = "Failed to Invoke : ${e.message}";
    }

    setState(() {
      _responseFromNativeCode = response;
    });
  }
}