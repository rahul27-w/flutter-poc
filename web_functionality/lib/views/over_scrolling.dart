import 'package:flutter/material.dart';

class OverScrolling extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('Demo')),
          body: ListView.builder(
            itemCount: 50,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(title: Text('Index $index'));
            },
          ),
        )
    );
  }
}