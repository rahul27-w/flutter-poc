import 'package:flutter/material.dart';

class SelectText extends StatefulWidget {
  const SelectText({Key key}) : super(key: key);

  @override
  _SelectTextState createState() => _SelectTextState();
}

class _SelectTextState extends State<SelectText> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _node = FocusNode();

  void _onPressed() {
    TextSelection selection = _controller.selection as TextSelection;

    print("selection.start: ${selection.start}");
    print("selection.end: ${selection.end}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              focusNode: _node,
              controller: _controller,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _onPressed,
              child: const Text("Do Something"),
            ),
          ],
        ),
      ),
    );
  }
}


