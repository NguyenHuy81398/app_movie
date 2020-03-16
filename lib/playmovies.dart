import 'dart:async';
import 'package:app_movie/comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seekbar/seekbar.dart';
import 'package:video_player/video_player.dart';
import 'model.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PlayMoviePage extends StatefulWidget {
  List<Video> videos;
  Video videoPlay;
  PlayMoviePage({Key key, @required this.videos, this.videoPlay}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _PlayMoviePageState();
  }
}

class _PlayMoviePageState extends State<PlayMoviePage> {
  VideoPlayerController _videoPlayerController;
  Future<void> _initializeVideoPlayerFuture;

  String _timeValue = "0.00:000";
  Timer _movieTimer;
  Timer _timerShowControlMovie;
  double _value = 0.0;
  double _secondValue = 0.0;
  bool _done = false;
  bool _isShowIFMovie = true;
  bool _isFullScreenVideo = false;
  double _heightMovie = 208.0;
  double _marginTopSeekBar = 155.0;
  bool isShowControlMovie = true;

  String _timeMovie() {
    _movieTimer = Timer.periodic(const Duration(milliseconds: 1000), (_) {
      setState(() {
        _timeValue = _videoPlayerController.value.position.toString();
        if (_videoPlayerController.value.position < _videoPlayerController.value.duration) {
          _value = _videoPlayerController.value.position.inMilliseconds / _videoPlayerController.value.duration.inMilliseconds;
        } else {
          _done = true;
        }
      });
      if (_value >= 1) {
        _movieTimer.cancel();
      }
    });
    return _timeValue;
  }

  String _getDurationMovie() {
    if (_videoPlayerController.value.duration.toString() == "null") {
      return "00:00";
    } else {
      return _videoPlayerController.value.duration.toString().substring(2, 7);
    }
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.network(widget.videoPlay.file_mp4);
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
    _videoPlayerController.play();
    if(isShowControlMovie){
        _timerShowControlMovie = Timer.periodic(Duration(seconds: 4), (_){
          setState(() {
            isShowControlMovie = false;
            _timerShowControlMovie.cancel();
          });
        });
    }
  }



  Widget showIFMovie() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("${widget.videoPlay.title}", style: TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
        Container(
            margin: const EdgeInsets.only(top: 2.0),
            child: Text("${widget.videoPlay.date_created}",
              style: TextStyle(color: Colors.white, fontSize: 12),)
        ),
      ],
    );
  }

  _onTapMovie(){
    if(isShowControlMovie == true){
      setState(() {
        isShowControlMovie = false;
      });
    }else{
      setState(() {
        isShowControlMovie = true;
        _timerShowControlMovie = Timer.periodic(Duration(seconds: 3), (_){
          setState(() {
            isShowControlMovie = false;
            _timerShowControlMovie.cancel();
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _isFullScreenVideo ? SizedBox(width: 0.0, height: 0.0,) : Container(height: 25.0, color: Colors.black87,),

            Container(
              height: _heightMovie,
              width: screen.width,
              child: Stack(
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        _onTapMovie();
                      },
                      child: FutureBuilder(
                        future: _initializeVideoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return AspectRatio(
                              aspectRatio: _videoPlayerController.value.aspectRatio,
                              child: VideoPlayer(_videoPlayerController),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator(backgroundColor: Colors.amberAccent,),);
                          }
                        },
                      ),
                    ),

                    Visibility(
                      visible: isShowControlMovie,
                      child: Container(
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
                                icon: Icon(
                                  _videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.amberAccent, size: 45,),
                                onPressed: () {
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
                    ),

                    Visibility(
                      visible: isShowControlMovie,
                      child: Container(
                        margin: EdgeInsets.only(top: _marginTopSeekBar),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 9,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 5.0, right: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("${_timeMovie().substring(2, 7)}", style: TextStyle(color: Colors.white, fontSize: 13),),
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
                                        onStartTrackingTouch: () {
                                          print("onStartTrackingTouch");
                                          if (!_done) {
                                          }
                                        },
                                        onProgressChanged: (value) {
                                          print('onProgressChanged: $value');
                                          _value = value;
                                        },
                                        onStopTrackingTouch: () {
                                          print('onStopTrackingTouch');
                                          if (!_done) {
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
                                    icon: Icon(_isFullScreenVideo ? Icons.fullscreen_exit : Icons.fullscreen, color: Colors.amberAccent),
                                    onPressed: () {
                                      if (_isFullScreenVideo) {
                                        setState(() {
                                          SystemChrome.setPreferredOrientations([
                                            DeviceOrientation.portraitUp,
                                            DeviceOrientation.portraitDown,
                                          ]);
                                          _heightMovie = 208.0;
                                          _marginTopSeekBar = 160.0;
                                          _isFullScreenVideo = false;
                                        });
                                      } else {
                                        setState(() {
                                          SystemChrome.setPreferredOrientations([
                                            DeviceOrientation.landscapeRight,
                                            DeviceOrientation.landscapeLeft,
                                          ]);
                                          _heightMovie = 360.0;
                                          _marginTopSeekBar = 320.0;
                                          _isFullScreenVideo = true;
                                        });
                                      }
                                    }),
                              ),
                            )
                          ],
                        ),
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

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _movieTimer?.cancel();
    super.dispose();
  }

  Widget screenMovie() {
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
                        icon: Icon(_isShowIFMovie? Icons.arrow_drop_down : Icons.arrow_drop_up, color: Colors.amberAccent,),
                        onPressed: () {
                          if (_isShowIFMovie == true) {
                            setState(() {
                              _isShowIFMovie = false;
                            });
                          } else {
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
                margin: const EdgeInsets.only(top: 10.0, left: 10.0,),
                child: Text("Bình luận", style: TextStyle(fontSize: 12, color: Colors.amberAccent, fontWeight: FontWeight.bold),)
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 5.0),
              height: 300.0,
              child: CommentPage(),
            ),

            Container(
                margin: const EdgeInsets.only(top: 10.0, left: 10.0, bottom: 2.0),
                child: Text("Phim liên quan", style: TextStyle(fontSize: 12, color: Colors.amberAccent, fontWeight: FontWeight.bold),)
            ),

            Container(
              child: CarouselSlider(
                autoPlay: false,
                viewportFraction: 0.7,
                aspectRatio: 2.0,
                items: widget.videos.map((movie) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        return null;
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
                            padding: const EdgeInsets.only(
                                left: 15.0, top: 130.0),
                            child: Text(movie.title, style: TextStyle(fontSize: 11, color: Colors.amberAccent, fontWeight: FontWeight.bold),)
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget nShowIFMovie() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("${widget.videoPlay.title}", style: TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
        Container(
            margin: const EdgeInsets.only(top: 2.0),
            child: Text("${widget.videoPlay.date_created}",
              style: TextStyle(color: Colors.white, fontSize: 12),)
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