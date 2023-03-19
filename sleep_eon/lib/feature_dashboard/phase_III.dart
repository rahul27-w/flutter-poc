import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sleep_eon/feature_dashboard/model/health_request_model.dart';
import 'package:sleep_eon/feature_dashboard/phase_I.dart';
import 'package:sleep_eon/utils/loading_indicator.dart';
import 'package:sleep_eon/feature_dashboard/widget/reusable_card.dart';
import 'package:sleep_eon/feature_dashboard/widget/round_button.dart';
import 'package:sleep_eon/utils/constant.dart';

// ignore: must_be_immutable
class PhaseIII extends StatefulWidget {
  HealthRequest phaseIIRequest;

  PhaseIII(this.phaseIIRequest);

  @override
  _PhaseIIIState createState() => _PhaseIIIState();
}

class _PhaseIIIState extends State<PhaseIII> {
  TextEditingController medicalRecordController = TextEditingController();
  bool caffeineNicotineIntake = false;
  bool meditation = false;
  double sleepRating = 0.0;
  int activityIndex = 0;
  int sleepDuration = 0;
  String medicalRecord;
  String _userId;

  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  double sleepScore;

  String recommendation;

  String reason;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kAppBarName, style: phaseButtonTextStyle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ///Caffeine/Nicotine & Meditation
            Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    color: ColorStyles.darkBlue,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          kCaffeine_Nicotine,
                          style: labelTextStyle,
                        ),
                        Text(
                          caffeineNicotineIntake ? kYes : kNo,
                          //alcoholConsumption.toString(),
                          style: numberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.times,
                              onPressed: () {
                                setState(() {
                                  caffeineNicotineIntake = false;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.check,
                              onPressed: () {
                                setState(() {
                                  caffeineNicotineIntake = true;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    color: ColorStyles.darkBlue,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          kMeditation,
                          style: labelTextStyle,
                        ),
                        Text(
                          meditation ? kYes : kNo,
                          style: numberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.times,
                              onPressed: () {
                                setState(() {
                                  meditation = false;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.check,
                              onPressed: () {
                                setState(() {
                                  meditation = true;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            ///Sleep Rating
            ReusableCard(
              color: ColorStyles.darkBlue,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(kSleepRating, style: labelTextStyle),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(sleepRating.toString(), style: numberTextStyle),
                    ],
                  ),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: ColorStyles.darkOrange,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        sleepRating = rating;
                      });
                    },
                  ),
                ],
              ),
            ),

            ///Activity Index
            ReusableCard(
              color: ColorStyles.darkBlue,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(kActivityIndex, style: labelTextStyle),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(activityIndex.toString(), style: numberTextStyle),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 30.0),
                        thumbColor: ColorStyles.orange,
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: ColorStyles.grayishBlue,
                        overlayColor: ColorStyles.overlayGold),
                    child: Slider(
                      value: activityIndex.toDouble(),
                      min: 0.0,
                      max: 10.0,
                      onChanged: (double newValues) {
                        setState(() {
                          activityIndex = newValues.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            ///Sleep Duration
            ReusableCard(
              color: ColorStyles.darkBlue,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    kSleepDuration,
                    style: labelTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(sleepDuration.toString(), style: numberTextStyle),
                      Text(kSleepMeasure, style: labelTextStyle),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RoundIconButton(
                        icon: FontAwesomeIcons.minus,
                        onPressed: () {
                          setState(() {
                            if (sleepDuration > 0) sleepDuration--;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      RoundIconButton(
                        icon: FontAwesomeIcons.plus,
                        onPressed: () {
                          setState(() {
                            sleepDuration++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            ///Previous Medical History
            ReusableCard(
              color: ColorStyles.darkBlue,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    kMedicalRecord,
                    style: labelTextStyle,
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: medicalRecordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: kMedicalRecordEntry,
                      labelStyle: textFieldStyle,
                    ),
                    style: textFieldStyle,
                    onChanged: (value) {
                      setState(() {
                        medicalRecord = value;
                      });
                    },
                  )
                ],
              ),
            ),
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                child: Text(kCalculate, style: phaseButtonTextStyle),
                color: ColorStyles.darkOrange,
                margin: EdgeInsets.only(top: 10.0),
                width: double.infinity,
                height: bottomContainerHeight,
              ),
              onTap: () {
                _calculateSleep();
              },
            ),
          ],
        ),
      ),
    );
  }

  _calculateSleep() async {
    HealthRequest request = HealthRequest(
      gender: widget.phaseIIRequest.gender,
      height: widget.phaseIIRequest.height,
      weight: widget.phaseIIRequest.weight,
      age: widget.phaseIIRequest.age,
      glucoseLevel: widget.phaseIIRequest.glucoseLevel,
      systolicBp: widget.phaseIIRequest.systolicBp,
      diastolicBp: widget.phaseIIRequest.diastolicBp,
      alcoholConsumption: widget.phaseIIRequest.alcoholConsumption,
      smoking: widget.phaseIIRequest.smoking,
      heartRate: widget.phaseIIRequest.heartRate,
      caffeineNicotineIntake: caffeineNicotineIntake,
      meditation: meditation,
      sleepRating: sleepRating,
      activityIndex: activityIndex,
      sleepDuration: sleepDuration,
      medicalRecord: medicalRecord,
    );
    try {
      LoadingIndicator.show("Calculating...");
      _userId = _auth.currentUser.uid.toString();
      await _fireStore
          .collection('user_details')
          .doc(_userId)
          .collection('health_record')
          .doc(_userId)
          .set(request.toJson());
      _calculateSleepScore();
      LoadingIndicator.dismiss();
    } catch (e) {
      LoadingIndicator.dismiss();
      print(e);
    }
  }

  int _randomGeneratedCode() {
    Random random = new Random();
    return random.nextInt(10000000);
  }

  AwesomeDialog awesomeDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.BOTTOMSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.SUCCES,
      autoHide: Duration(seconds: 22),
      dialogBackgroundColor: ColorStyles.darkBlue,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Thank You For Your Response',
                style: loginButtonTextStyle,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Text(
                  'Your Sleep Score is $sleepScore',
                  style: loginButtonTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text(
                  "Recommendation : $recommendation \n Reason : $reason",
                  textAlign: TextAlign.center,
                  style: loginButtonTextStyle,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset('assets/images/sleepCard.png'),
                ),
              ),
            ],
          ),
        ),
      ),
      // btnOk: _buildFancyButtonOk,
    )..show();
  }

  void _calculateSleepScore() {
    if (activityIndex == 2) {
      sleepScore = 2.5;
      recommendation = "Drink Plenty Of water";
      reason = "Malabsorption found in food";
    } else if (activityIndex == 3) {
      sleepScore = 2.8;
      recommendation = "Exercise for Atleast 30 minutes today";
      reason = "Lack of movement discovered";
    } else if (activityIndex == 5) {
      sleepScore = 3.6;
      recommendation = "Walk outside for 15 minutes to relax";
      reason = "Not enough movement";
    } else if (activityIndex == 6) {
      sleepScore = 3.9;
      recommendation = "Take a hot shower to optimize your sleep";
      reason = "Overstressed today";
    } else if (activityIndex == 8) {
      sleepScore = 4.2;
      recommendation = "Do oil pulling for clearing your throat";
      reason = "Clean throat and nose, lots of snorin last night";
    }
    awesomeDialog(context);
  }
}
