import 'package:app_movie/category.dart';
import 'package:app_movie/itemcategory.dart';
import 'package:app_movie/model.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryHome extends StatefulWidget {
  @override
  _CategoryHomeState createState() => _CategoryHomeState();
}

class _CategoryHomeState extends State<CategoryHome> {

  final url = "http://demo4855049.mockable.io/GetCategory";
  AsyncMemoizer<List<Category>> memCacheCategoryHome = AsyncMemoizer();

  Future<List<Category>> fetchCategories(http.Client client) async {
    return memCacheCategoryHome.runOnce(() async{
      final response = await client.get(url);
      List<dynamic> body = jsonDecode(response.body);
      List<Category> categories = body.map((dynamic item) => Category.fromJson(item)).toList();
      return categories;
    });

  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return FutureBuilder(
      future: fetchCategories(http.Client()),
      builder: (context, snapshot){
        return snapshot.hasData
            ? Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10.0, left: 8.0, bottom: 2.0),
              child: Row(
                children: <Widget>[
                  Text("Danh mục", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.amberAccent),),
                  const SizedBox(width: 240.0,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CategoryPage(categories: snapshot.data);
                      }));
                    },
                      child: Text("Tất cả", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.amberAccent),)
                  )
                ],
              ),
            ),
            CategoryList(categories: snapshot.data)
          ],
        )
            : Container(
                width: screen.width,
                height: screen.height/6 + 5.0,
                  child: Center(
                      child: SizedBox(),
          ),
        );
      },
    );
  }
}

class CategoryList extends StatelessWidget {
  final List<Category> categories;
  CategoryList({Key key, this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Container(
      width: screen.width,
      height: screen.height/6 + 5.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index){
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Item_Category(category: categories[index]);
                }));
              },
              child: Container(
                margin: const EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.all(5.0),
                        child: ClipOval(
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(categories[index].thumb), fit: BoxFit.cover
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0.5, 1.0),
                                      blurRadius: 7,
                                      color: Colors.amberAccent
                                  )
                                ]
                            ),
                          ),
                        )),
                    Container(
                        child: Text(categories[index].title, style: TextStyle(color: Colors.amberAccent, fontSize: 11.0, fontWeight: FontWeight.bold),)
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

