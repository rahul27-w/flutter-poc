import 'package:flutter/material.dart';

class ObscureText extends StatefulWidget {
  final String title;

  const ObscureText({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  _ObscureTextState createState() => _ObscureTextState();
}

class _ObscureTextState extends State<ObscureText> {
  String _text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You have entered: $_text',
              ),
              TextFormField(
                obscureText: true,
                onChanged: (text) {
                  print('Entered: $text');
                  setState(() {
                    _text = text;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
