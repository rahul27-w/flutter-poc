import 'package:flutter/material.dart';

class LoaderView extends StatefulWidget {
  const LoaderView({Key key}) : super(key: key);

  @override
  _LoaderViewState createState() => _LoaderViewState();
}

class _LoaderViewState extends State<LoaderView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
