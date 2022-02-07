import 'package:flutter/cupertino.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:practica_final_2/models/models.dart';

class MoviesProvider extends ChangeNotifier{ //Extiende changenotifier para ser un proveedor que afecta a main 
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '16c770aa416fc4922bf647185875504a';
  String _language = 'es-ES';
  String _page = '1';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovie = [];

  Map<int, List<Cast>> casting = {};

  MoviesProvider(){
    print('Movies Provider inicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  getOnDisplayMovies() async{ //Devuelve una lista del objeto Pelicula con las peliculas que se muestran actualmente
    print('getOnDisplayMovies');
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    // "Await" el "http" obtiene la respuesta, luego decodifica la respuesta con formato json.
    var result = await http.get(url);

    final nowPlayingResponse = NowPlayingMovies.fromJson(result.body); //Usa el modelo para recibir el json y convertirlo en objeto y crear una lista

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners(); //Notifica al resto de wisgets que se ha producido un cambio
  }

  getPopularMovies() async { //Devuelve una lista del objeto Pelicula con las peliculas populares
    print("getPopularMovies");
    // https://api.themoviedb.org/3/movie/popular?api_key=fd352d97d3d559950ac24beca2a78d7a&language=es-ES&page=1
    var url = Uri.http(_baseUrl, '3/movie/popular', //se cambia el url respecto al anterior y se usan las demas variables
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    final result = await http.get(url); //se obrtiene el json

    final popularMovies = PopularMovies.fromJson(result.body); //se ajusta la lista usando el modelo de popular_movie

    popularMovie = popularMovies.results; //convierte la lista antes creada en la lista ya completa con las pelis populares

    notifyListeners(); //Notifica al resto de wisgets que se ha producido un cambio
  }

  Future<List<Cast>> getMovieCast(int idMovie) async{ //Es un Future debido a que cambia constantemente

    print('Pide info al servidor');
    var url = Uri.http(_baseUrl, '3/movie/$idMovie/credits',
        {'api_key': _apiKey, 'language': _language});

    final result = await http.get(url); //Recibe la informacion del url en json

    final creditsResponse = CreditsResponse.fromJson(result.body); //se usa la clase de creditresponse para mapear el json

    casting[idMovie] = creditsResponse.cast; //Se le asigna a la lista mapeada junto con el id de la pelicula
    
    return creditsResponse.cast; //se retorna una lista de actores (el casting )
  }
}