import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sleep_eon/feature_dashboard/model/health_request_model.dart';
import 'package:sleep_eon/feature_dashboard/phase_II.dart';
import 'package:sleep_eon/feature_dashboard/widget/reusable_card.dart';
import 'package:sleep_eon/feature_dashboard/widget/round_button.dart';
import 'package:sleep_eon/feature_recording/record_audio.dart';
import 'package:sleep_eon/utils/constant.dart';

enum GenderType { male, female }

class PhaseI extends StatefulWidget {
  @override
  _PhaseIState createState() => _PhaseIState();
}

class _PhaseIState extends State<PhaseI> {
  GenderType selectedGender;
  int height = kHeightValue;
  int weight = kWeightValue;
  int age = kAgeValue;
  double glucoseLevel = kGlucoseValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kAppBarName, style: phaseButtonTextStyle),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(24.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => RecorderView()),
            );
          },
          child: Container(
            height: 45,
            width: 45,
            child: Icon(
              Icons.mic,
              color: ColorStyles.white,
              size: 30,
            ),
          ),
          backgroundColor: ColorStyles.darkOrange,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            ///Male & Female
            Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    color: selectedGender == GenderType.male
                        ? ColorStyles.blackBlue
                        : ColorStyles.darkBlue,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.mars,
                          size: 80.0,
                          color: ColorStyles.white,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          kMale,
                          style: labelTextStyle,
                        ),
                      ],
                    ),
                    onPress: () {
                      setState(() {
                        selectedGender = GenderType.male;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    color: selectedGender == GenderType.female
                        ? ColorStyles.blackBlue
                        : ColorStyles.darkBlue,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.venus,
                          size: 80.0,
                          color: ColorStyles.white,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          kFemale,
                          style: labelTextStyle,
                        ),
                      ],
                    ),
                    onPress: () {
                      setState(() {
                        selectedGender = GenderType.female;
                      });
                    },
                  ),
                ),
              ],
            ),

            ///Height
            ReusableCard(
              color: ColorStyles.darkBlue,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(kHeight, style: labelTextStyle),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(height.toString(), style: numberTextStyle),
                      Text(kCm, style: labelTextStyle),
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
                      value: height.toDouble(),
                      min: 120.0,
                      max: 220.0,
                      onChanged: (double newValues) {
                        setState(() {
                          height = newValues.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            ///Weight & Age
            Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    color: ColorStyles.darkBlue,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          kWeight,
                          style: labelTextStyle,
                        ),
                        Text(
                          weight.toString(),
                          style: numberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  weight--;
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
                                  weight++;
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
                          kAge,
                          style: labelTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: numberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  age--;
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
                                  age++;
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

            /// Glucose Level
            ReusableCard(
              color: ColorStyles.darkBlue,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(kGlucoseLevel, style: labelTextStyle),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(glucoseLevel.toString(), style: numberTextStyle),
                      Text(kGlucoseMeasure, style: labelTextStyle),
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
                      value: glucoseLevel.toDouble(),
                      min: 2.6,
                      max: 21.1,
                      onChanged: (double newValues) {
                        setState(() {
                          glucoseLevel =
                              double.parse((newValues).toStringAsFixed(2));
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                child: Text(kNext, style: phaseButtonTextStyle),
                color: ColorStyles.darkOrange,
                margin: EdgeInsets.only(top: 10.0),
                width: double.infinity,
                height: bottomContainerHeight,
              ),
              onTap: () {
                HealthRequest request = HealthRequest(
                  gender: selectedGender.toString(),
                  height: height,
                  weight: weight,
                  age: age,
                  glucoseLevel: glucoseLevel,
                );
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PhaseII(request)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
