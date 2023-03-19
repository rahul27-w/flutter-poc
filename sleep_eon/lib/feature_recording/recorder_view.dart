import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sleep_eon/feature_recording/record_audio.dart';

class RecordAudio extends StatefulWidget {
  @override
  _RecordAudioState createState() => _RecordAudioState();
}

class _RecordAudioState extends State<RecordAudio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: RecorderView()),
    );
  }
}
