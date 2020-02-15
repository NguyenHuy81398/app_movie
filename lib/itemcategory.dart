
import 'package:app_movie/playmovies.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'model.dart';

class Item_Category extends StatelessWidget{

  Category category;
  Item_Category({Key key, @required this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    // TODO: implement build
    return MaterialApp(
      title: "Item Category",
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: <Widget>[
            const SizedBox(height: 24.0,),
            Container(
              height: screen.height/5 + 13.0,
              width: screen.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(category.thumb),
                    fit: BoxFit.cover
                ),
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
                      )
                  ),

                  padding: const EdgeInsets.only(left: 10.0, top: 100.0),
                  child: Text(category.title, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.amberAccent),)
              ),
            ),
            Container(
              color: Colors.amberAccent,
              height: 1.0,
            ),
            IC_HomePage(),
          ],
        ),
      ),
    );
  }
}

class IC_HomePage extends StatefulWidget{
  @override
  _IC_HomePageState createState() => _IC_HomePageState();
}

class _IC_HomePageState extends State<IC_HomePage>{

  final urlItemCategory = "http://demo4855049.mockable.io/getItemCategory01";

  Future<List<Video>> fetchItemCategories(http.Client client) async {
    final response = await client.get(urlItemCategory);
    List<dynamic> body = jsonDecode(response.body);
    List<Video> itemCategories = body.map((dynamic item) => Video.fromJson(item)).toList();
    return itemCategories;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: fetchItemCategories(http.Client()),
      builder: (context, snapshot){
        return snapshot.hasData
            ? MovieCategoryList(movies: snapshot.data)
            : Container(
                height: 474.0,
                  child: Center(
                      child: CircularProgressIndicator(backgroundColor: Colors.amberAccent,)
          ),
        );
      },
    );
  }
}

class MovieCategoryList extends StatelessWidget {
  final List<Video> movies;
  MovieCategoryList({Key key, this.movies}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 474.0,
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.3,
        scrollDirection: Axis.vertical,
        children: movies.map((itemCategory){
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return PlayMoviePage(videos: movies, videoPlay: itemCategory,);
              }));
            },
            child: Container(
              margin: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(itemCategory.avatar),
                      fit: BoxFit.fill
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0.5, 1.0),
                        blurRadius: 5,
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
                    borderRadius: BorderRadius.circular(5.0)
                  ),

                  padding: const EdgeInsets.only(left: 5.0, top: 110.0, right: 5.0),
                  child: Text(
                    itemCategory.title,
                    style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 12.0),
                    overflow: TextOverflow.ellipsis,
                  )
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
