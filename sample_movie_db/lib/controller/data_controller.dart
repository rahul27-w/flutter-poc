import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_movie_db/model/popular_movie_response.dart';
import 'package:sample_movie_db/model/top_rated_movie_response.dart';
import 'package:sample_movie_db/model/upcoming_movie_response.dart';
import 'package:sample_movie_db/network/api_repository.dart';

class DataController extends GetxController with SingleGetTickerProviderMixin{
  static DataController get find => Get.find();
  ApiRepository _repository = ApiRepository();
  AnimationController animationController;
  Animation<double> animation;

  RxBool isLoading = false.obs;
  Rx<PopularMovieResponse> popularMovie = PopularMovieResponse().obs;
  Rx<UpcomingMovieResponse> upcomingMovie = UpcomingMovieResponse().obs;
  Rx<TopRatedMovieResponse> topRatedMovie = TopRatedMovieResponse().obs;

  @override
  void onInit() {
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 200));
    animation = Tween<double>(begin: 0, end: 1.0).animate(animationController)
      ..addListener(() => update());
    fetchPopularMovies(1);
    fetchUpcomingMovies(1);
    fetchTopRatedMovies(1);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void fetchPopularMovies(int page) async {
    try {
      isLoading(true);
      PopularMovieResponse popularMovieResponse =
          await _repository.getPopularMovies(page);
      if (popularMovieResponse.results.length > 0) {
        popularMovie(popularMovieResponse);
      }
    } finally {
      isLoading(false);
    }
  }

  void fetchUpcomingMovies(int page) async {
    try {
      isLoading(true);
      UpcomingMovieResponse upcomingMovieResponse =
          await _repository.getUpcomingMovies(page);
      if (upcomingMovieResponse.results.length > 0) {
        upcomingMovie(upcomingMovieResponse);
      }
    } finally {
      isLoading(false);
    }
  }

  void fetchTopRatedMovies(int page) async {
    try {
      isLoading(true);
      TopRatedMovieResponse topRatedMovieResponse =
          await _repository.getTopRatedMovies(page);
      if (topRatedMovieResponse.results.length > 0) {
        topRatedMovie(topRatedMovieResponse);
      }
    } finally {
      isLoading(false);
    }
  }
}
