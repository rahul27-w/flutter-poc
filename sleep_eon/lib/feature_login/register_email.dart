import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sleep_eon/feature_login/model/register_model.dart';
import 'package:sleep_eon/feature_login/register_mobile.dart';
import 'package:sleep_eon/utils/constant.dart';

class RegisterEmail extends StatefulWidget {
  @override
  _RegisterEmailState createState() => _RegisterEmailState();
}

class _RegisterEmailState extends State<RegisterEmail> {
  final _formKey = GlobalKey<FormState>();

  //final _auth = FirebaseAuth.instance;
  //final _fireStore =  FirebaseFirestore.instance;
  String _email, _password, _confirmPassword, _userId;

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
                      leading: Icon(Icons.email, color: ColorStyles.darkOrange),
                      title: TextFormField(
                        style: loginButtonTextStyle,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Your Email',
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
                          hintText: 'Create Your Password',
                          hintStyle: loginButtonTextStyle,
                        ),
                        validator: (val) => val.isEmpty ? "*Required" : null,
                        onSaved: (val) => _password = val,
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
                          hintText: 'Confirm Your Password',
                          hintStyle: loginButtonTextStyle,
                        ),
                        validator: (val) => val.isEmpty ? "*Required" : null,
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
                      child: Text('Next', style: loginButtonTextStyle),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    RegisterMobile(_email, _password)),
                          );
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

// void registerUser() async{
//   try{
//     final newUser = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
//     if(newUser != null){
//       _userId = _auth.currentUser.uid.toString();
//       _firestore.collection('user_details').doc(_userId).set({
//         'fname' : _fName,
//         'lname' : _lName,
//         'email' : _email,
//         'phone' : _phone
//       });
//       Navigator.push(context, MaterialPageRoute(
//           builder: (context) => Welcome()));
//     }
//   }catch(e){
//     print(e);
//   }
// }
}
