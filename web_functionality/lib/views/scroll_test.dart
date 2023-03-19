import 'package:flutter/material.dart';

class ScrollTest extends StatefulWidget {
  @override
  _ScrollTestState createState() => _ScrollTestState();
}

class _ScrollTestState extends State<ScrollTest> {
  final List<Color> _colors = [Colors.red, Colors.blue, Colors.black];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: List.generate(3, (index) => Container(
          color: _colors[index],
          height: MediaQuery.of(context).size.height,
        )),
      ),
    );
  }
}