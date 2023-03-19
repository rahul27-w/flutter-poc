// To parse this JSON data, do
//
//     final topRatedMovieResponse = topRatedMovieResponseFromJson(jsonString);

import 'dart:convert';

import 'upcoming_movie_response.dart';

TopRatedMovieResponse topRatedMovieResponseFromJson(String str) => TopRatedMovieResponse.fromJson(json.decode(str));

String topRatedMovieResponseToJson(TopRatedMovieResponse data) => json.encode(data.toJson());

class TopRatedMovieResponse {
  TopRatedMovieResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  factory TopRatedMovieResponse.fromJson(Map<String, dynamic> json) => TopRatedMovieResponse(
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
