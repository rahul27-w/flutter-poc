// To parse this JSON data, do
//
//     final popularMovieResponse = popularMovieResponseFromJson(jsonString);

import 'dart:convert';

import 'package:sample_movie_db/model/upcoming_movie_response.dart';

PopularMovieResponse popularMovieResponseFromJson(String str) => PopularMovieResponse.fromJson(json.decode(str));

String popularMovieResponseToJson(PopularMovieResponse data) => json.encode(data.toJson());

class PopularMovieResponse {
  PopularMovieResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  factory PopularMovieResponse.fromJson(Map<String, dynamic> json) => PopularMovieResponse(
    page: json["page"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

enum OriginalLanguage { EN, ES, JA }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "es": OriginalLanguage.ES,
  "ja": OriginalLanguage.JA
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
