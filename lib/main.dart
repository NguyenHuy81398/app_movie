
import 'package:app_movie/categoryhome.dart';
import 'package:app_movie/login_page.dart';
import 'package:app_movie/movienew.dart';
import 'package:app_movie/search.dart';
import 'package:app_movie/splashscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'header.dart';
import 'model.dart';
import 'dart:convert';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Json",
      home: SplashScreenPage(),
      routes: <String, WidgetBuilder>{
        '/HomePage':(BuildContext context)=> HomePage()
      },
    );
  }
}

class HomePage extends StatefulWidget{
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  final url = "http://demo4855049.mockable.io/gethotvideo";
  List<Video> movies;

  @override
  Widget build(BuildContext context) {

    Future<List<Video>> fetchMovies(http.Client client) async {
      final response = await client.get(url);
      List<dynamic> body = jsonDecode(response.body);
      movies = body.map((dynamic item) => Video.fromJson(item)).toList();
      return movies;
    }

    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("NDH", style: TextStyle(color: Colors.amberAccent, fontSize: 25, fontWeight: FontWeight.w900, fontFamily: "BlackOpsOne-Regular"),),
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.amberAccent,),
            onPressed: (){
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(icon: Icon(Icons.search, color: Colors.amberAccent,), onPressed: (){
                showSearch(context: context, delegate: DataSearch(listVideos: movies));
              }),
            )
          ],
          elevation: 10.0,
        ),

        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                      color: Colors.amberAccent,
                  ),
                  accountName: Text("Nguyễn Danh Huy", style: TextStyle(color: Colors.black),),
                  accountEmail: Text("nguyenhuy81398@gmail.com", style: TextStyle(color: Colors.black),),
                  currentAccountPicture: Container(
                    width: 10.0,
                    height: 10.0,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Text("H", style: TextStyle(fontSize: 20.0, color: Colors.amberAccent),),
                    ),
                  ),
                ),

                ListTile(
                  title: Text("Hành động", style: TextStyle(color: Colors.amberAccent),),
                  leading: Icon(Icons.border_color, color: Colors.red,),
                ),

                ListTile(
                  title: Text("Tình cảm", style: TextStyle(color: Colors.amberAccent),),
                  leading: Icon(Icons.photo, color: Colors.blue,),
                ),

                ListTile(
                  title: Text("Viễn tưởng", style: TextStyle(color: Colors.amberAccent),),
                  leading: Icon(Icons.audiotrack, color: Colors.amber,),
                ),

                ListTile(
                  title: Text("Giải trí", style: TextStyle(color: Colors.amberAccent),),
                  leading: Icon(Icons.movie, color: Colors.green,),
                ),

                ListTile(
                  title: Text("Đăng nhập", style: TextStyle(color: Colors.amberAccent),),
                  leading: Icon(Icons.person, color: Colors.blueGrey,),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return LoginPage();
                    }));
                  },
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Container(
                  child: FutureBuilder(
                    future: fetchMovies(http.Client()),
                    builder: (context, snapshot){
                      return snapshot.hasData ? carouselSlider(context, snapshot.data): SizedBox();
                    },
                  ),
              ),


              CategoryHome(),
              MovieNew()
            ],
          ),
        )
    );
  }
}