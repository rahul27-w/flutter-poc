import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_sharedpreferences/services/shared_preferences_service.dart';
import 'package:universal_html/html.dart' as html;
import 'package:universal_html/html.dart';

import '../routes.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final PrefService _prefService = PrefService();
  String videoLocalPath;

  @override
  void initState() {
    super.initState();
    firebaseOnMessage();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text("Some Functionality"),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: (){
                  _checkCameraPermission(context);
                },
                child: Text("Camera Permission")),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: (){
                  _checkMicrophonePermission(context);
                },
                child: Text("Microphone Permission")),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: (){
                  _readFirebaseData();
                },
                child: Text("Read Data")),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: (){
                  _onFileUpload();
                },
                child: Text("Upload Data")),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  await _prefService.removeCache("password").whenComplete(() {
                    Navigator.of(context).pushNamed(LoginRoute);
                  });
                },
                child: Text("Log out")),
          ],
        ),
      ),
    );
  }

  void _checkCameraPermission(BuildContext context) async{
    PermissionStatus permission = await html.window.navigator.permissions.query({"name": "camera"});
    if (permission.state == "denied") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Oops! Camera access denied!"),
        backgroundColor: Colors.orangeAccent,
      ));
      return;
    }
    final stream = await html.window.navigator.getUserMedia(video: true);
  }

  void _checkMicrophonePermission(BuildContext context) async{
    PermissionStatus permission = await window.navigator.permissions
        .query({'name': 'microphone'});
    if(permission.state == "denied"){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Oops! Microphone access denied!"),
        backgroundColor: Colors.orangeAccent,
      ));
      return;
    }
    final stream = await html.window.navigator.getUserMedia(audio: true);

  }

  void firebaseOnMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      if(message != null){
        final title = message.notification.title;
        final body = message.notification.body;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Title : $title, Body: $body'))
        );
      }
    });
  }

  Future<void> _readFirebaseData() async{
    final firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance.collection("featured").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print("Hello : ${result.data()}");
      });
    });
  }

  void _pickVideoFromFile(
      {@required Function(File file) onSelected}){
    InputElement uploadInput = FileUploadInputElement()..accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final file = uploadInput.files.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        onSelected(file);
      });
    });
  }

  Future<void> _onFileUpload() async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    final dateTime = DateTime.now();
    final path = '$dateTime';
    _pickVideoFromFile(onSelected: (file) async{
      try {
        await firebaseStorage
            .ref('upload-image-file')
            .child(path)
            .putBlob(file);
      } catch (error) {
        print('Error occurred while uploading to Firebase ${error.toString()}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error occurred while uploading'),
          ),
        );
      }
    });

  }

}
