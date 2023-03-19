// To parse this JSON data, do
//
//     final healthRequest = healthRequestFromJson(jsonString);

import 'dart:convert';

HealthRequest healthRequestFromJson(String str) => HealthRequest.fromJson(json.decode(str));

String healthRequestToJson(HealthRequest data) => json.encode(data.toJson());

class HealthRequest {
  HealthRequest({
    this.activityIndex,
    this.age,
    this.alcoholConsumption,
    this.caffeineNicotineIntake,
    this.diastolicBp,
    this.gender,
    this.glucoseLevel,
    this.heartRate,
    this.height,
    this.medicalRecord,
    this.meditation,
    this.sleepDuration,
    this.sleepRating,
    this.smoking,
    this.systolicBp,
    this.weight,
  });

  int activityIndex;
  int age;
  bool alcoholConsumption;
  bool caffeineNicotineIntake;
  int diastolicBp;
  String gender;
  double glucoseLevel;
  int heartRate;
  int height;
  String medicalRecord;
  bool meditation;
  int sleepDuration;
  double sleepRating;
  bool smoking;
  int systolicBp;
  int weight;

  factory HealthRequest.fromJson(Map<String, dynamic> json) => HealthRequest(
    activityIndex: json["activity-index"],
    age: json["age"],
    alcoholConsumption: json["alcohol-consumption"],
    caffeineNicotineIntake: json["caffeine-nicotine-intake"],
    diastolicBp: json["diastolic-bp"],
    gender: json["gender"],
    glucoseLevel: json["glucose-level"].toDouble(),
    heartRate: json["heart-rate"],
    height: json["height"],
    medicalRecord: json["medical-record"],
    meditation: json["meditation"],
    sleepDuration: json["sleep-duration"],
    sleepRating: json["sleep-rating"].toDouble(),
    smoking: json["smoking"],
    systolicBp: json["systolic-bp"],
    weight: json["weight"],
  );

  Map<String, dynamic> toJson() => {
    "activity-index": activityIndex,
    "age": age,
    "alcohol-consumption": alcoholConsumption,
    "caffeine-nicotine-intake": caffeineNicotineIntake,
    "diastolic-bp": diastolicBp,
    "gender": gender,
    "glucose-level": glucoseLevel,
    "heart-rate": heartRate,
    "height": height,
    "medical-record": medicalRecord,
    "meditation": meditation,
    "sleep-duration": sleepDuration,
    "sleep-rating": sleepRating,
    "smoking": smoking,
    "systolic-bp": systolicBp,
    "weight": weight,
  };
}

// import 'package:sleep_eon/feature_dashboard/phase_I.dart';
//
// class HealthRequest{
//   GenderType gender;
//   int height;
//   int weight;
//   int age;
//   double glucoseLevel;
//   int systolicBP;
//   int diastolicBP;
//   int heartRate;
//   bool alcoholConsumption;
//   bool smoking;
//   bool caffeineNicotineIntake;
//   bool meditation;
//   double sleepRating;
//   int activityIndex;
//   int sleepDuration;
//   String medicalRecord;
//
//   HealthRequest({
//     this.gender,
//     this.height,
//     this.weight,
//     this.age,
//     this.glucoseLevel,
//     this.systolicBP,
//     this.diastolicBP,
//     this.heartRate,
//     this.alcoholConsumption,
//     this.smoking,
//     this.caffeineNicotineIntake,
//     this.meditation,
//     this.sleepRating,
//     this.activityIndex,
//     this.sleepDuration,
//     this.medicalRecord
//   });
// }
