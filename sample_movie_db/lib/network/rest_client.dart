import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:sample_movie_db/model/popular_movie_response.dart';
import 'package:sample_movie_db/model/top_rated_movie_response.dart';
import 'package:sample_movie_db/model/upcoming_movie_response.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://api.themoviedb.org/3')

abstract class RestClient{
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/movie/popular?")
  Future<PopularMovieResponse> getPopularMovie(
      @Query("api_key") String apiKey,
      @Query("language") String language,
      @Query("page") int page);

  @GET("/movie/upcoming?")
  Future<UpcomingMovieResponse> getUpcomingMovie(
      @Query("api_key") String apiKey,
      @Query("language") String language,
      @Query("page") int page);

  @GET("/movie/top_rated?")
  Future<TopRatedMovieResponse> getTopRatedMovie(
      @Query("api_key") String apiKey,
      @Query("language") String language,
      @Query("page") int page);
}