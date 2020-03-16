import 'dart:convert';
import 'dart:async';
import 'package:app_movie/playmovies.dart';
import 'package:async/async.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

class MovieNew extends StatefulWidget {
  @override
  _MovieNewState createState() => _MovieNewState();
}

class _MovieNewState extends State<MovieNew> {
  final url = "http://demo4855049.mockable.io/gethotvideo";
  AsyncMemoizer<List<Video>> memCacheMovieNew = AsyncMemoizer();

  Future<List<Video>> fetchMovies(http.Client client) async {
    return memCacheMovieNew.runOnce(() async{
      final response = await client.get(url);
      List<dynamic> body = jsonDecode(response.body);
      List<Video> movies = body.map((dynamic item) => Video.fromJson(item)).toList();
      return movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchMovies(http.Client()),
      builder: (context, snapshot){
        return snapshot.hasData 
            ? MovieNewList(movies: snapshot.data)
            : Container(
                margin: const EdgeInsets.all(20.0),
                child: Center(child: CircularProgressIndicator(backgroundColor: Colors.amberAccent,),
            )
        );
      },
    );
  }
}

class MovieNewList extends StatelessWidget {
  final List<Video> movies;
  MovieNewList({Key key, this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 8.0, bottom: 10.0),
            child: Row(
              children: <Widget>[
                Text("Phim mới", style: TextStyle(fontSize: 14, color: Colors.amberAccent, fontWeight: FontWeight.bold),),
                const SizedBox(width: 240.0,),
                GestureDetector(
                  onTap: (){

                  },
                    child: Text("Tất cả", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.amberAccent),)
                )
              ],
            ),
        ),

        CarouselSlider(
          autoPlay: false,
          viewportFraction: 0.9,
          aspectRatio: 1.7,
          enlargeCenterPage: true,
          items: movies.map((movie){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return PlayMoviePage(videos: movies, videoPlay: movie,);
                  }));
                },
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(movie.avatar),
                          fit: BoxFit.cover
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0.2, 1.0),
                            blurRadius: 2,
                            color: Colors.amberAccent
                        )
                      ]
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: const [
                              Colors.black,
                              Colors.black12
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment(0.0, 0.0)
                        ),
                          borderRadius: BorderRadius.circular(12.0)
                      ),

                      padding: const EdgeInsets.only(left: 15.0, top: 150.0),

                      child: Text(movie.title, style: TextStyle(fontSize: 16, color: Colors.amberAccent, fontWeight: FontWeight.bold),)
                  ),
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}

