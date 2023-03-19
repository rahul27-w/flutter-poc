import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sleep_eon/feature_dashboard/model/health_request_model.dart';
import 'package:sleep_eon/feature_dashboard/phase_I.dart';
import 'package:sleep_eon/feature_dashboard/phase_III.dart';
import 'package:sleep_eon/feature_dashboard/widget/reusable_card.dart';
import 'package:sleep_eon/feature_dashboard/widget/round_button.dart';
import 'package:sleep_eon/utils/constant.dart';

// ignore: must_be_immutable
class PhaseII extends StatefulWidget {
  HealthRequest phaseIRequest;

  PhaseII(this.phaseIRequest);

  @override
  _PhaseIIState createState() => _PhaseIIState();
}

class _PhaseIIState extends State<PhaseII> {
  int systolicBP = kSystolicBP;
  int diastolicBP = kDiastolicBP;
  int heartRate = kHeartRateValue;
  bool alcoholConsumption = false;
  bool smoking = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kAppBarName, style: phaseButtonTextStyle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ///Systolic (Blood Pressure)
            ReusableCard(
              color: ColorStyles.darkBlue,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(kSystolicLevel, style: labelTextStyle),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(systolicBP.toString(), style: numberTextStyle),
                      Text(kBPMeasure, style: labelTextStyle),
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
                      value: systolicBP.toDouble(),
                      min: 70,
                      max: 180,
                      onChanged: (double newValues) {
                        setState(() {
                          systolicBP = newValues.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            ///Diastolic (Blood Pressure)
            ReusableCard(
              color: ColorStyles.darkBlue,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(kDiastolicLevel, style: labelTextStyle),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(diastolicBP.toString(), style: numberTextStyle),
                      Text(kBPMeasure, style: labelTextStyle),
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
                      value: diastolicBP.toDouble(),
                      min: 40,
                      max: 100,
                      onChanged: (double newValues) {
                        setState(() {
                          diastolicBP = newValues.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            ///Alcohol & Smoking
            Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    color: ColorStyles.darkBlue,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          kAlcoholConsumption,
                          style: labelTextStyle,
                        ),
                        Text(
                          alcoholConsumption ? kYes : kNo,
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
                                  alcoholConsumption = false;
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
                                  alcoholConsumption = true;
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
                          kSmokingConsumption,
                          style: labelTextStyle,
                        ),
                        Text(
                          smoking ? kYes : kNo,
                          style: numberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.times,
                              onPressed: () {
                                setState(() {
                                  smoking = false;
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
                                  smoking = true;
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

            ///Heart Rate
            ReusableCard(
              color: ColorStyles.darkBlue,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(kHeartRate, style: labelTextStyle),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(heartRate.toString(), style: numberTextStyle),
                      Text(kHeartRateMeasure, style: labelTextStyle),
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
                      value: heartRate.toDouble(),
                      min: 0,
                      max: 200,
                      onChanged: (double newValues) {
                        setState(() {
                          heartRate = newValues.round();
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
                  gender: widget.phaseIRequest.gender,
                  height: widget.phaseIRequest.height,
                  weight: widget.phaseIRequest.weight,
                  age: widget.phaseIRequest.age,
                  glucoseLevel: widget.phaseIRequest.glucoseLevel,
                  systolicBp: systolicBP,
                  diastolicBp: diastolicBP,
                  alcoholConsumption: alcoholConsumption,
                  smoking: smoking,
                  heartRate: heartRate,
                );
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PhaseIII(request)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
