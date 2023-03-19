import 'dart:io';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:sleep_eon/utils/constant.dart';
import 'package:sleep_eon/utils/loading_indicator.dart';



// ignore: must_be_immutable
class RecorderView extends StatefulWidget {
  @override
  _RecorderViewState createState() => _RecorderViewState();
}

///For Recording Status
enum RecordingState {
  UnSet,
  Set,
  Recording,
  Stopped,
}

class _RecorderViewState extends State<RecorderView>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  ///Start And End Time Of Timer
  int startClock = 0;
  int endClock = 120;

  String audioPath;
  String statusText;
  String recordFilePath;
  String _userId;

  bool _isCancelButton = false;
  bool _isCheckButton = false;
  bool _isEnable = false;
  bool _isUploading;
  String mTimerText = "00:00";

  String _recordIcon = 'assets/images/recording_mic.png';
  RecordingState _recordingState = RecordingState.UnSet;

  final _auth = FirebaseAuth.instance;


  @override
  void initState() {
    super.initState();
    _isUploading = false;
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: endClock));
    animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _recordingState = RecordingState.Set;
    _recordIcon = 'assets/images/recording_mic.png';
  }

  @override
  void dispose() {
    _recordingState = RecordingState.UnSet;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black87,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
                child: GestureDetector(
                    onTap: (){
                      if (audioPath != null) {
                        RecordMp3.instance.stop();
                        final deleteFile = Directory(audioPath);
                        deleteFile.deleteSync(recursive: true);
                      }
                      Navigator.of(context).pop();
                    },
                    child:Image.asset('assets/images/back_button.png')
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 70.0, horizontal: 20.0),
                child: LinearProgressIndicator(
                  minHeight: 3.0,
                  value: animation.value,
                  backgroundColor: Colors.white,
                  valueColor:
                  new AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                ),
              ),
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "assets/images/sound_wave.png",
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(height: 20),
                  _isEnable
                      ? Countdown(
                    animation: StepTween(
                      begin: startClock, // THIS IS A USER ENTERED NUMBER
                      end: endClock,
                    ).animate(_controller),
                    timerCompleteCallback:
                        (isTimerComplete, timerText) async {
                      _recordingState = RecordingState.Recording;
                      _isEnable = false;
                      mTimerText = timerText;
                      await _onRecordButtonPressed();
                      setState(() {});
                    },
                  )
                      : Container(
                    padding: EdgeInsets.only(
                        left: 12.0, right: 12.0, top: 2.0, bottom: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Text(
                      mTimerText,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Visibility(
                          visible: _isCancelButton,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 40.0),
                            child: RawMaterialButton(
                              onPressed: () {
                                _onCancelButtonPressed();
                                setState(() {});
                              },
                              elevation: 2.0,
                              child: Image.asset('assets/images/recording_cross.png'),
                            ),
                          ),
                        ),
                        SizedBox(width: 40),
                        GestureDetector(                      // <-- Take picture
                          onTap: () async{
                            _isEnable = true;
                            await _onRecordButtonPressed();
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: Container(
                              height: 70.0,
                              width: 70.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3.0,
                                ),
                              ),
                              child: Image.asset(_recordIcon),
                            ),
                          ),
                        ),
                        SizedBox(width: 40),
                        Visibility(
                          visible: _isCheckButton,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 40.0),
                            child: RawMaterialButton(
                              onPressed: () {
                                if (audioPath != null) {
                                  _onFileUpload();
                                }
                              },
                              elevation: 2.0,
                              child: Image.asset('assets/images/recording_check.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _startRecording() async {
    statusText = "Recording...";
    recordFilePath = await getFilePath();
    _controller.reset();
    _controller.forward();
    RecordMp3.instance.start(recordFilePath, (type) {
      statusText = "Record error--->$type";
      setState(() {});
    });
  }

  Future<String> getFilePath() async {
    Directory appDirectory = await getTemporaryDirectory();
    audioPath = appDirectory.path +
        '/' +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.mp3';
    return audioPath;
  }

  Future<void> _onRecordButtonPressed() async {
    print('RecordingState $_recordingState');
    switch (_recordingState) {
      case RecordingState.Set:
        await _recordVoice();
        break;

      case RecordingState.Recording:
        await _stopRecording();
        _recordingState = RecordingState.Stopped;
        _recordIcon = 'assets/images/recording_mic.png';
        _isCheckButton = true;
        _isCancelButton = true;
        break;

      case RecordingState.Stopped:
        await _recordVoice();
        _isCheckButton = false;
        _isCancelButton = false;
        break;

      case RecordingState.UnSet:
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please allow recording from settings.'),
        ));
        break;
    }
  }

  Future<void> _recordVoice() async {
    _startRecording();
    _recordingState = RecordingState.Recording;
    _recordIcon = 'assets/images/recording_stop.png';
  }

  _stopRecording() async {
    bool recordingStatus = RecordMp3.instance.stop();
    _controller.stop();
    if (recordingStatus) {
      statusText = "Record complete";
    }
  }

  _onCancelButtonPressed() {
    _controller.reset();
    _isCheckButton = false;
    _isCancelButton = false;
    mTimerText = "00:00";
    final deleteFile = Directory(audioPath);
    deleteFile.deleteSync(recursive: true);
    audioPath = null;
  }

  Future<void> _onFileUpload() async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    _userId = _auth.currentUser.uid.toString();

    setState(() {
      _isUploading = true;
    });
    try {
      LoadingIndicator.show('Uploading File');
      await firebaseStorage
          .ref('upload-recording-file')
          .child(_userId)
          .putFile(File(audioPath));
      LoadingIndicator.dismiss();
    } catch (error) {
      print('Error occurred while uploading to Firebase ${error.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error occurred while uploading'),
        ),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
    Navigator.pop(context);
  }

}
///When Timer complete give callback which help us to stop recording.
typedef CallBackToFunc = void Function(bool isTimerComplete, String timerText);
///For Recording Clock
// ignore: must_be_immutable
class Countdown extends AnimatedWidget {
  CallBackToFunc timerCompleteCallback;

  Countdown({Key key, this.animation, this.timerCompleteCallback})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString().padLeft(2, '0')}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    if (animation.isCompleted) {
      print("TimerComplete");
      timerCompleteCallback(true, timerText);
    }
    return Container(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 2.0, bottom: 2.0),
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      child: Text(
        "$timerText",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: ColorStyles.white,
        ),
      ),
    );
  }
}

