import 'package:dio/dio.dart';

class MovieApiProvider {
  static const kApiKey =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5YmU5OTg4MWFjYzgzNzE3YTM3NmExYTBmZTM5OTc3NyIsInN1YiI6IjVmOThjMWU1NzE5YWViMDAzODVmNmQ5MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.8_9Ve3ufFVPQmUYvmlLf4d85qQAwjzV8Cf5fc7jMRmc";

  final dio = Dio(BaseOptions(
    responseType: ResponseType.json,
  ));

  Future<Map<String, dynamic>> fetchAllMovies(int page) async {
    var path = 'https://api.themoviedb.org/3/discover/movie';

    var options = Options(headers: {'Authorization': 'Bearer $kApiKey'});

    var result = await dio.get(path, options: options, queryParameters: {
      'page': page,
    });

    return result.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> searchMovies(String query) async {
    var path = 'https://api.themoviedb.org/3/search/movie';

    var options = Options(headers: {'Authorization': 'Bearer $kApiKey'});

    var result = await dio.get(path, options: options, queryParameters: {
      'page': 1,
      'query': query,
    });

    return result.data as Map<String, dynamic>;
  }
}
