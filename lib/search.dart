
import 'package:app_movie/model.dart';
import 'package:app_movie/playmovies.dart';
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
        file_mp4: "",
        date_created: ""),
    Video(
        title: "Anna Trailer #1 (2019) | Movieclips Trailers",
        avatar: "https://dzbbmecpa0hd2.cloudfront.net/video/avatar/2019/04/11/13/1554965823_34100e85b0bdcb5d.jpg",
        file_mp4: "",
        date_created: ""),
  ];

  DataSearch({this.listVideos});

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(icon: Icon(Icons.clear), onPressed: (){
      query = "";
    },)];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
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
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final suggestionLists = query.isEmpty? recentVideos: listVideos.where((p) => p.title.startsWith(query)).toList();
    return ListView.builder(
      itemCount: suggestionLists.length,
        itemBuilder: (context, index){
      return ListTile(
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
            borderRadius: BorderRadius.circular(5.0)
          ),
        ),
        title: Text("${suggestionLists[index].title}", style: TextStyle(fontSize: 13)),
      );
    });
  }

}