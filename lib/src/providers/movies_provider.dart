import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';


import 'package:movies/src/models/movie_model.dart';

class MoviesProvider {

  String _apiKey        = '837db7f7081108a3c56e88f84d3ec1d2';
  String _url           = 'api.themoviedb.org';
  String _language      = 'es-ES';
  int _popularPage      = 0;

  List<Movie> _populars = new List();

  final _popularsStreamController = StreamController<List<Movie>>.broadcast();

  Function (List<Movie>) get popularsSink => _popularsStreamController.sink.add;

  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

  void disposeStreams(){
    _popularsStreamController?.close();
  }

  Future<List<Movie>> _proccessResponse(Uri url) async  {

    final response   = await http.get(url);
    final decodeData = json.decode(response.body);
    final movies     = new Movies.fromJsonList(decodeData['results']);

    return movies.items;
  }

  Future<List<Movie>> getInTheaters() async {

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'   : _apiKey,
      'language'  :_language
    });

    return await _proccessResponse(url);
  }

  Future<List<Movie>> getPopulars() async {

    _popularPage++;

    print('cargando siguientes....');

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key'   : _apiKey,
      'language'  :_language,
      'page'      : _popularPage.toString()
    });

    final response = await _proccessResponse(url);

    _populars.addAll(response);
    popularsSink(_populars);

//    _loadPage = false;
    return response;
  }
}