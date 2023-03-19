import 'package:flutter/material.dart';
import 'package:flutter_web_sharedpreferences/routes.dart';

class FunctionalityScreen extends StatefulWidget {
  const FunctionalityScreen({Key key}) : super(key: key);

  @override
  _FunctionalityScreenState createState() => _FunctionalityScreenState();
}

class _FunctionalityScreenState extends State<FunctionalityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Web Functionality')),
      body: SafeArea(
        child: Expanded(
          child: Center(
            child: Column(
              children: [
                Spacer(),
                ElevatedButton(
                  child: Text("Splash Screen", style: TextStyle(fontSize: 30)),
                  onPressed: () {
                    Navigator.of(context).pushNamed(SplashRoute);
                  }, //function
                ),
                Spacer(),
                ElevatedButton(
                  child: Text("Obsure Text", style: TextStyle(fontSize: 30)),
                  onPressed: () {
                    Navigator.of(context).pushNamed(ObsureRoute);
                  }, //function
                ),
                Spacer(),
                ElevatedButton(
                  child: Text("Over Scrolling", style: TextStyle(fontSize: 30)),
                  onPressed: () {
                    Navigator.of(context).pushNamed(OverScrollingRoute);
                  }, //function
                ),
                Spacer(),
                ElevatedButton(
                  child: Text("Scrolling", style: TextStyle(fontSize: 30)),
                  onPressed: () {
                    Navigator.of(context).pushNamed(ScrollTestRoute);
                  }, //function
                ),
                Spacer(),
                ElevatedButton(
                  child: Text("Text Selection", style: TextStyle(fontSize: 30)),
                  onPressed: () {
                    Navigator.of(context).pushNamed(TextSelectionRoute);
                  }, //function
                ),
                Spacer(),
                ElevatedButton(
                  child: Text("Loader", style: TextStyle(fontSize: 30)),
                  onPressed: () {
                    Navigator.of(context).pushNamed(LoaderRoute);
                  }, //function
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
