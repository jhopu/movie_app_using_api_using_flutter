import 'dart:convert';


import 'movie.dart';
import 'package:http/http.dart' as http;
class Api{
  static const trendingUrl="https://api.themoviedb.org/3/trending/movie/day?api_key=fc12b443c632dd532a33bcc033612042";
  static const topRatedUrl="https://api.themoviedb.org/3/movie/top_rated?api_key=fc12b443c632dd532a33bcc033612042";
  static const upcomingUrl="https://api.themoviedb.org/3/movie/upcoming?api_key=fc12b443c632dd532a33bcc033612042";
  Future<List<Movie>> getTrendingMovies() async{
    final response=await http.get(Uri.parse(trendingUrl));
    if(response.statusCode==200){
      final decodeData=jsonDecode(response.body)['results'] as List;
//print(decodeData);
      return decodeData.map((movie)=>Movie.fromJson(movie)).toList();
    }
    else{
      throw Exception('Something happened');

    }

  }
  Future<List<Movie>> getTopRatedMovies() async{
    final response=await http.get(Uri.parse(topRatedUrl));
    if(response.statusCode==200){
      final decodeData=jsonDecode(response.body)['results'] as List;
//print(decodeData);
      return decodeData.map((movie)=>Movie.fromJson(movie)).toList();
    }
    else{
      throw Exception('Something happened');

    }

  }

  Future<List<Movie>> getupcomingMovies() async{
    final response=await http.get(Uri.parse(upcomingUrl));
    if(response.statusCode==200){
      final decodeData=jsonDecode(response.body)['results'] as List;
//print(decodeData);
      return decodeData.map((movie)=>Movie.fromJson(movie)).toList();
    }
    else{
      throw Exception('Something happened');

    }

  }
}