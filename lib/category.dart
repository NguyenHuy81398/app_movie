
import 'package:app_movie/model.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  List<Category> categories;
  CategoryPage({Key key, this.categories}): super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Danh mục phim", style: TextStyle(color: Colors.amberAccent),),
      ),
      body: ListView.builder(
          itemCount: widget.categories.length,
          itemBuilder: (context, index){
            return Container(
              height: screen.height / 4,
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(widget.categories[index].thumb), fit: BoxFit.cover)
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

                  padding: const EdgeInsets.only(left: 10.0, top: 120.0),

                  child: Text(widget.categories[index].title, style: TextStyle(fontSize: 20, color: Colors.amberAccent, fontStyle: FontStyle.normal),)),
            );
          }),
    );
  }
}


