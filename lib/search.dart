
import 'package:app_movie/model.dart';
import 'package:app_movie/playmovies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String>{

  List<Video> listVideos;
  List<Video> recentVideos = [
    Video(
        title: "THE LAST SUMMER Official Trailer (2019) Romance Netflix Movie HD",
        avatar: "https://dzbbmecpa0hd2.cloudfront.net/video/avatar/2019/04/11/14/1554966002_de58c8a6be7d1046.jpg",
        file_mp4: "https://dzbbmecpa0hd2.cloudfront.net/video/original/2019/04/11/14/1554966002_de58c8a6be7d1046.mp4",
        date_created: "2019-04-11 13:25:49"),

    Video(
        title: "THE PROFESSOR Official Trailer (2019) Johnny Depp, Zoey Deutch Movie HD",
        avatar: "https://dzbbmecpa0hd2.cloudfront.net/video/avatar/2019/04/11/13/1554965830_3431956a34e3c241.jpg",
        file_mp4: "https://dzbbmecpa0hd2.cloudfront.net/video/original/2019/04/11/13/1554965830_3431956a34e3c241.mp4",
        date_created: "2019-04-13 09:00:50"),

    Video(
        title: "Anna Trailer #1 (2019) | Movieclips Trailers",
        avatar: "https://dzbbmecpa0hd2.cloudfront.net/video/avatar/2019/04/11/13/1554965823_34100e85b0bdcb5d.jpg",
        file_mp4: "https://dzbbmecpa0hd2.cloudfront.net/video/original/2019/04/11/13/1554965823_34100e85b0bdcb5d.mp4",
        date_created: "2019-04-13 08:00:31"),
  ];

  DataSearch({this.listVideos});

  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.yellowAccent[100], fontSize: 16)
      ),
      primaryColor: Colors.black,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.amberAccent),
      primaryColorBrightness: Brightness.dark,
      primaryTextTheme: theme.textTheme.copyWith(title: theme.textTheme.title.copyWith(color: Colors.amberAccent)),
      textTheme: theme.textTheme.copyWith(title: theme.textTheme.title.copyWith(color: Colors.amberAccent))
    );
  }

  @override
  String get searchFieldLabel => "Tìm kiếm phim";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear,), color: Colors.amberAccent, onPressed: (){
      query = "";
    },)];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionLists = query.isEmpty? recentVideos: listVideos.where((p) => p.title.startsWith(query)).toList();
    return Container(
      color: Colors.black,
      child: ListView.builder(
        itemCount: suggestionLists.length,
          itemBuilder: (context, index){
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0,),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.5, color: Colors.grey, style: BorderStyle.solid)
              )
          ),
          child: ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return PlayMoviePage(videos: suggestionLists, videoPlay: suggestionLists[index],);
              }));
            },
            leading: Container(
              width: 60.0,
              height: 50.0,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(suggestionLists[index].avatar)),
                borderRadius: BorderRadius.circular(15.0),

              ),
            ),
            title: RichText(
              text: TextSpan(
                  text: suggestionLists[index].title.substring(0, query.length), style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(text: suggestionLists[index].title.substring(query.length), style: TextStyle(color: Colors.grey,))
                  ]
              ),
            ),
          ),
        );
      }),
    );
  }
}