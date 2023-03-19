import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sleep_eon/feature_dashboard/phase_I.dart';
import 'package:sleep_eon/feature_login/login_page.dart';
import 'package:sleep_eon/feature_login/model/register_model.dart';
import 'package:sleep_eon/utils/constant.dart';
import 'package:sleep_eon/utils/loading_indicator.dart';

// ignore: must_be_immutable
class RegisterMobile extends StatefulWidget {
  String email;
  String password;

  RegisterMobile(this.email, this.password);

  @override
  _RegisterMobileState createState() => _RegisterMobileState();
}

class _RegisterMobileState extends State<RegisterMobile> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  String _firstName, _lastName, _phone, _userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kRegister, style: phaseButtonTextStyle),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.6,
                    //width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/images/register_image.png',
                    ),
                  ),
                  Card(
                    color: ColorStyles.darkBlue,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
                    child: ListTile(
                      leading:
                          Icon(Icons.people, color: ColorStyles.darkOrange),
                      title: TextFormField(
                        style: loginButtonTextStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'First Name',
                          hintStyle: loginButtonTextStyle,
                        ),
                        validator: (val) => val.isEmpty ? "*Required" : null,
                        onSaved: (val) => _firstName = val,
                      ),
                    ),
                  ),
                  Card(
                    color: ColorStyles.darkBlue,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
                    child: ListTile(
                      leading:
                          Icon(Icons.people, color: ColorStyles.darkOrange),
                      title: TextFormField(
                        style: loginButtonTextStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Last Name',
                          hintStyle: loginButtonTextStyle,
                        ),
                        validator: (val) => val.isEmpty ? "*Required" : null,
                        onSaved: (val) => _lastName = val,
                      ),
                    ),
                  ),
                  Card(
                    color: ColorStyles.darkBlue,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
                    child: ListTile(
                      leading: Icon(Icons.phone, color: ColorStyles.darkOrange),
                      title: TextFormField(
                        style: loginButtonTextStyle,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Phone Number',
                          hintStyle: loginButtonTextStyle,
                        ),
                        validator: (val) => val.isEmpty ? "*Required" : null,
                        onSaved: (val) => _phone = val,
                      ),
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
                          EdgeInsets.symmetric(vertical: 15.0, horizontal: 25),
                      child: Text('Register', style: loginButtonTextStyle),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          registerUser();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void registerUser() async {
    try {
      LoadingIndicator.show("Register...");
      final result = await _auth.createUserWithEmailAndPassword(
          email: widget.email, password: widget.password);
      if (result != null) {
        RegisterModel model = RegisterModel(
            email: widget.email,
            firstName: _firstName,
            lastName: _lastName,
            phone: _phone);
        _userId = _auth.currentUser.uid.toString();
        _fireStore.collection('user_details').doc(_userId).set(model.toJson());
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
        LoadingIndicator.dismiss();
      }
    } catch (e) {
      LoadingIndicator.dismiss();
      print(e);
    }
  }
}
