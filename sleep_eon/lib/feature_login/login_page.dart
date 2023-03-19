import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sleep_eon/feature_dashboard/phase_I.dart';
import 'package:sleep_eon/feature_login/register_email.dart';
import 'package:sleep_eon/utils/constant.dart';
import 'package:sleep_eon/utils/loading_indicator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kLogin, style: phaseButtonTextStyle),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.6,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/images/login_image.gif',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Card(
                    color: ColorStyles.darkBlue,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
                    child: ListTile(
                      leading: Icon(Icons.email, color: ColorStyles.darkOrange),
                      title: TextFormField(
                        autofocus: false,
                        style: loginButtonTextStyle,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: kEmail,
                          hintStyle: loginButtonTextStyle,
                        ),
                        validator: (val) => val.isEmpty ? "*Required" : null,
                        onSaved: (val) => _email = val,
                      ),
                    ),
                  ),
                  Card(
                    color: ColorStyles.darkBlue,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
                    child: ListTile(
                      leading: Icon(Icons.lock, color: ColorStyles.darkOrange),
                      title: TextFormField(
                        obscureText: true,
                        style: loginButtonTextStyle,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: kPassword,
                            hintStyle: loginButtonTextStyle),
                        validator: (val) => val.isEmpty ? "*Required" : null,
                        onSaved: (val) => _password = val,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      FirebaseCrashlytics.instance.crash();
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: EdgeInsets.only(right: 25.0),
                        child: Text(
                          kForgotPassword,
                          style: loginButtonTextStyle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      textColor: ColorStyles.white,
                      color: ColorStyles.darkOrange,
                      padding:
                          EdgeInsets.symmetric(vertical: 20.0, horizontal: 25),
                      child: Text(kLogin, style: loginButtonTextStyle),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          _loginWithEmailPassword();
                        }
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      textColor: ColorStyles.white,
                      color: ColorStyles.darkOrange,
                      padding:
                          EdgeInsets.symmetric(vertical: 20.0, horizontal: 25),
                      child: Text(kNewUser, style: loginButtonTextStyle),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RegisterEmail()));
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _loginWithEmailPassword() async {
    try {
      LoadingIndicator.show("Login");
      final user = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);

      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PhaseI()));
        LoadingIndicator.dismiss();
      } else {
        _showToast(kInvalidUser);
        LoadingIndicator.dismiss();
      }
    } catch (e) {
      print(e);
      _showToast(e.toString());
      LoadingIndicator.dismiss();
    }
  }

  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: ColorStyles.darkBlue,
        textColor: ColorStyles.white,
        fontSize: 16.0);
  }
}
