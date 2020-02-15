import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seekbar/seekbar.dart';
import 'package:video_player/video_player.dart';
import 'model.dart';

class PlayMoviePage extends StatefulWidget{
  List<Video> videos;
  Video videoPlay;

  PlayMoviePage({Key key, @required this.videos, this.videoPlay}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PlayMoviePageState();
  }
}

class _PlayMoviePageState extends State<PlayMoviePage>{
  VideoPlayerController _videoPlayerController;
  Future<void> _initializeVideoPlayerFuture;
  double _value = 0.0;
  double _secondValue = 0.0;
  String _timeValue = "0.00:000";
  Timer _progressTimer;
  Timer _movieTimer;
  Timer _secondProgressTimer;
  bool _done = false;
  bool _isShowIFMovie = true;
  bool _isFullScreenVideo = false;
  double _heightMovie = 208.0;
  double _maginTopSeekBar = 155.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _videoPlayerController = VideoPlayerController.network(widget.videoPlay.file_mp4);
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();

    _videoPlayerController.play();

    _resumeProgressTimer();
    _secondProgressTimer = Timer.periodic(const Duration(milliseconds: 1000), (_){
      if(_videoPlayerController.value.duration.toString() != "null"){
        setState(() {
          if(_videoPlayerController.value.position < _videoPlayerController.value.duration){
            _secondValue += 0.01;
          }else{
            _secondProgressTimer.cancel();
          }
        });
      }
    });
  }

  @override
  void dispose(){
    _videoPlayerController.dispose();
    _secondProgressTimer?.cancel();
    super.dispose();
  }

  _resumeProgressTimer(){
    _progressTimer = Timer.periodic(const Duration(milliseconds: 1000), (_){
      if(_videoPlayerController.value.duration.toString() != "null"){
        setState(() {
          if(_videoPlayerController.value.position < _videoPlayerController.value.duration){
            _value = _videoPlayerController.value.position.inMilliseconds/_videoPlayerController.value.duration.inMilliseconds;
          }else{
            _progressTimer.cancel();
            _done = true;
          }
        });
      }
    });
  }

  String _timeMovie(){
    _movieTimer = Timer.periodic(const Duration(milliseconds: 1000), (_){
      setState(() {
        _timeValue = _videoPlayerController.value.position.toString();
        if(_timeValue.contains(_videoPlayerController.value.duration.toString())){
          _movieTimer.cancel();
        }
      });
    });
    return _timeValue;
  }

  String _getDurationMovie(){
    if(_videoPlayerController.value.duration.toString() == "null"){
      return "00:00";
    }else{
      return _videoPlayerController.value.duration.toString().substring(2,7);
    }
  }

  Widget showIFMovie(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("${widget.videoPlay.title}", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
        Container(
            margin: const EdgeInsets.only(top: 2.0),
            child: Text("${widget.videoPlay.date_created}", style: TextStyle(color: Colors.white, fontSize: 12),)
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
//        appBar: AppBar(
//          title: Text("AAAAA"),
//          backgroundColor: Colors.blue,
//        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _isFullScreenVideo? SizedBox(width: 0.0, height: 0.0,): Container(height: 25.0, color: Colors.black87,),

              Container(
                height: _heightMovie,
                width: screen.width,
                child: Stack(
                    children: <Widget>[
                      Container(
                        child: FutureBuilder(
                          future: _initializeVideoPlayerFuture,
                          builder: (context, snapshot){
                            if(snapshot.connectionState == ConnectionState.done){
                              return AspectRatio(
                                aspectRatio: _videoPlayerController.value.aspectRatio,
                                child: VideoPlayer(_videoPlayerController),
                              );
                            }else{
                              return Center(child: CircularProgressIndicator(),);
                            }
                          },
                        ),
                      ),

                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(top: 2.0),
                                child: IconButton(
                                    icon: Icon(Icons.replay_10, color: Colors.amberAccent, size: 30,)
                                ),
                              )
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(_videoPlayerController.value.isPlaying ? Icons.pause: Icons.play_arrow, color: Colors.amberAccent, size: 45,),
                              onPressed: (){
                                setState(() {
                                  _videoPlayerController.value.isPlaying
                                      ? _videoPlayerController.pause()
                                      : _videoPlayerController.play();
                                });
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.only(top: 5.0),
                              child: IconButton(
                                  icon: Icon(Icons.forward_10, color: Colors.amberAccent, size: 30,)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                      Container(
                        margin: EdgeInsets.only(top: _maginTopSeekBar),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 9,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("${_timeMovie().substring(2,7)}", style: TextStyle(color: Colors.white, fontSize: 13),),
                                        Text("${_getDurationMovie()}", style: TextStyle(color: Colors.white, fontSize: 13),),
                                      ],
                                    ),
                                  ),

                                  Container(
                                      margin: const EdgeInsets.all(2.0),
                                      child: SeekBar(
                                        value: _value,
                                        secondValue: _secondValue,
                                        progressColor: Colors.amberAccent,
                                        secondProgressColor: Colors.amberAccent.withOpacity(0.5),
                                        onStartTrackingTouch: (){
                                          print("onStartTrackingTouch");
                                          if(!_done){
                                            _progressTimer?.cancel();
                                          }
                                        },
                                        onProgressChanged: (value){
                                          print('onProgressChanged: $value');
                                          _value = value;
                                        },
                                        onStopTrackingTouch: (){
                                          print('onStopTrackingTouch');
                                          if(!_done){
                                            _resumeProgressTimer();
                                          }
                                        },
                                      )
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              flex: 1,
                              child: Container(
                                child: IconButton(
                                    icon: Icon(_isFullScreenVideo? Icons.fullscreen_exit: Icons.fullscreen, color: Colors.amberAccent),
                                    onPressed: (){
                                      if(_isFullScreenVideo){
                                        setState(() {
                                          SystemChrome.setPreferredOrientations([
                                            DeviceOrientation.portraitUp,
                                            DeviceOrientation.portraitDown,
                                          ]);
                                          _heightMovie = 208.0;
                                          _maginTopSeekBar = 160.0;
                                          _isFullScreenVideo = false;
                                        });
                                      }else{
                                        setState(() {
                                          SystemChrome.setPreferredOrientations([
                                            DeviceOrientation.landscapeRight,
                                            DeviceOrientation.landscapeLeft,
                                          ]);
                                          _heightMovie = 360.0;
                                          _maginTopSeekBar = 320.0;
                                          _isFullScreenVideo = true;
                                        });
                                      }
                                    }),
                              ),
                            )
                          ],
                        ),
                      )
                    ]
                ),
              ),

              _isFullScreenVideo? SizedBox(width: 0.0, height: 0.0,): screenMovie(),

            ],
          ),
        ),
    );
  }

  Widget screenMovie(){
    return Container(
      height: 407.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(top: 8.0, left: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        flex: 10,
                        child: Container(
                          child: _isShowIFMovie? showIFMovie(): nShowIFMovie(),
                        )
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(_isShowIFMovie
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up, color: Colors.amberAccent,),
                        onPressed: (){
                          if(_isShowIFMovie == true){
                            setState(() {
                              _isShowIFMovie = false;
                            });
                          }else{
                            setState(() {
                              _isShowIFMovie = true;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                )
            ),

            Container(
                margin: const EdgeInsets.only(top: 10.0, left: 10.0, bottom: 2.0),
                child: Text("Phim liên quan", style: TextStyle(fontSize: 12, color: Colors.amberAccent, fontWeight: FontWeight.bold),)
            ),

            Container(
              padding: const EdgeInsets.all(0.0),
              margin: const EdgeInsets.all(0.0),
              height: 342.0,
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                scrollDirection: Axis.vertical,
                children: widget.videos.map((movies){
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){

                      }));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(movies.avatar),
                              fit: BoxFit.fill
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0.5, 1.0),
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
                              borderRadius: BorderRadius.circular(5.0)
                          ),

                          padding: const EdgeInsets.only(left: 5.0, top: 120.0, right: 5.0),
                          child: Text(
                            movies.title,
                            style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 12.0),
                            overflow: TextOverflow.ellipsis,
                          )
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget nShowIFMovie(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("${widget.videoPlay.title}", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
        Container(
            margin: const EdgeInsets.only(top: 2.0),
            child: Text("${widget.videoPlay.date_created}", style: TextStyle(color: Colors.white, fontSize: 12),)
        ),
        Text("AAAAAAAA", style: TextStyle(color: Colors.white),),
        Text("AAAAAAAA", style: TextStyle(color: Colors.white),),
        Text("AAAAAAAA", style: TextStyle(color: Colors.white),),
        Text("AAAAAAAA", style: TextStyle(color: Colors.white),),
        Text("AAAAAAAA", style: TextStyle(color: Colors.white),),
        Text("AAAAAAAA", style: TextStyle(color: Colors.white),),
      ],
    );
  }

}