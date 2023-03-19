import 'package:flutter/material.dart';
import 'package:flutter_web_sharedpreferences/services/shared_preferences_service.dart';

import '../routes.dart';

class LoginView extends StatelessWidget {
  final PrefService _prefService = PrefService();
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login"),
      ),
      body: Center(
        child: Container(
          width: 400.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: email,
                decoration: InputDecoration(
                    border: new OutlineInputBorder(), hintText: "Enter email"),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: password,
                decoration: InputDecoration(
                    border: new OutlineInputBorder(),
                    hintText: "Enter password"),
              ),
              SizedBox(
                height: 40.0,
              ),
              ElevatedButton(
                  onPressed: () async {
                    _prefService.createCache(password.text).whenComplete(() {
                      if (email.text.isNotEmpty && password.text.isNotEmpty) {
                        Navigator.of(context).pushNamed(HomeRoute);
                      }
                    });
                  },
                  child: Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}
