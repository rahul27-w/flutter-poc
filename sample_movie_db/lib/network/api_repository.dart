import 'package:dio/dio.dart';
import 'package:sample_movie_db/model/popular_movie_response.dart';
import 'package:sample_movie_db/model/top_rated_movie_response.dart';
import 'package:sample_movie_db/model/upcoming_movie_response.dart';
import 'package:sample_movie_db/network/rest_client.dart';
import 'package:sample_movie_db/utils/constant.dart';

class ApiRepository{
  final RestClient _restClient;

  ApiRepository({restClient}):
        _restClient = restClient ?? RestClient(Dio());

  Future<PopularMovieResponse> getPopularMovies(int page) async{
    String apiKey = kApiKey;
    String language = kLanguage;
    return await _restClient.getPopularMovie(apiKey, language, page);
  }

  Future<UpcomingMovieResponse> getUpcomingMovies(int page) async{
    String apiKey = kApiKey;
    String language = kLanguage;
    return await _restClient.getUpcomingMovie(apiKey, language, page);
  }

  Future<TopRatedMovieResponse> getTopRatedMovies(int page) async{
    String apiKey = kApiKey;
    String language = kLanguage;
    return await _restClient.getTopRatedMovie(apiKey, language, page);
  }

}