import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const bottomContainerHeight = 80.0;

abstract class ColorStyles{
  // static const darkBlue = Color(0XFF1D1E33);
  // static const blackBlue = Color(0XFF111328);
  // static const white = Color(0XFFFFFFFF);
  // static const deepPink = Color(0XFFFF1493);
  // static const vividPink = Color(0XFFEB1555);
  // static const grayishBlue = Color(0XFF8D8E98);
  // static const overlayVividPink = Color(0X29EB1555);

  static const darkBlue = Color(0XFF1D1E33);
  static const blackBlue = Color(0XFF111328);
  static const white = Color(0XFFFFFFFF);
  static const darkOrange = Color(0XFFFF8C00);
  static const orange = Color(0XFFFFA500);
  static const grayishBlue = Color(0XFF8D8E98);
  static const overlayGold = Color(0X29FFD700);
}


const int kHeightValue = 180;
const int kWeightValue = 42;
const int kAgeValue = 19;
const int kSystolicBP = 120;
const int kDiastolicBP = 60;
const int kHeartRateValue = 92;
const double kGlucoseValue = 10.0;


const String kAppBarName = "Sleep Eon";
const String kMale = "MALE";
const String kFemale = "FEMALE";
const String kHeight = "HEIGHT";
const String kWeight = "WEIGHT";
const String kAge = "AGE";
const String kGlucoseLevel = "GLUCOSE LEVEL";
const String kSystolicLevel = "SYSTOLIC LEVEL (BP)";
const String kDiastolicLevel = "DIASTOLIC LEVEL (BP)";
const String kAlcoholConsumption = "ALCOHOL CONSUMPTION";
const String kSmokingConsumption = "SMOKING CONSUMPTION";
const String kSleepDuration = "SLEEP DURATION";
const String kHeartRate = "HEART RATE";
const String kMedicalRecord = "MEDICAL RECORD";
const String kCaffeine_Nicotine = "CAFFEINE/NICOTINE";
const String kMeditation = "DAILY MEDITATION";
const String kSleepRating = "SLEEP RATING";
const String kActivityIndex = "ACTIVITY INDEX";
const String kCm = "cm";
const String kGlucoseMeasure = "mmol/L";
const String kBPMeasure = "mm Hg";
const String kHeartRateMeasure = "bpm";
const String kSleepMeasure = "hr";
const String kYes = "Yes";
const String kNo = "No";
const String kNext = "NEXT";
const String kCalculate = "CALCULATE";
const String kMedicalRecordEntry = "Enter Medical Record";
const String kEmail = "Enter Your Email";
const String kPassword = "Enter Your Password";
const String kNewUser = "New User";
const String kLogin = ' Login ';
const String kForgotPassword = "Forgot Password?";
const String kRegister = ' Register ';
const String kInvalidUser = "Invalid User";


const labelTextStyle = TextStyle(
  fontSize:  16.0,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w600,
  color: ColorStyles.white,
);

const textFieldStyle = TextStyle(
  fontSize:  16.0,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w400,
  color: ColorStyles.white,
);

const numberTextStyle = TextStyle(
  fontSize:  50.0,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w900,
  color: ColorStyles.white,
);

const phaseButtonTextStyle = TextStyle(
  fontSize:  25.0,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w400,
  color: ColorStyles.white,
);

const loginButtonTextStyle = TextStyle(
    fontSize: 18,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    color: ColorStyles.white
);