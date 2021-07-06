import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsphobia/pages/home.dart';

import 'package:video_player/video_player.dart';
import 'package:timeago/timeago.dart' as timeago;

class Drecent extends StatefulWidget {
  final DocumentSnapshot post;
  Drecent({this.post});
  @override
  _DrecentState createState() => _DrecentState();
}

class _DrecentState extends State<Drecent> {
  back() {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => BNV()));
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.backspace),
            onPressed: back,
          ),
          centerTitle: true,
          title: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(widget.post.data['tittle'],
                  speed: Duration(milliseconds: 40)),
            ],
            repeatForever: true,
          ),
          backgroundColor: Colors.redAccent,
        ),
        body: Container(
          child: ListView(
            children: [
              if (widget.post.data['img2'] == '')
                VideoWidget(
                  play: true,
                  url: widget.post.data['video'],
                )
              else
                Image.network(
                  widget.post.data['img2'],
                  fit: BoxFit.cover,
                ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      widget.post.data['author'],
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Text(
                      timeago
                          .format(
                            DateTime.tryParse(
                              widget.post.data['time'].toDate().toString(),
                            ),
                          )
                          .toString(),
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ]),
              SizedBox(
                height: 10.0,
              ),
              ListTile(
                title: Text(
                  widget.post.data['desc'],
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class VideoWidget extends StatefulWidget {
  final bool play;
  final String url;

  const VideoWidget({Key key, @required this.url, @required this.play})
      : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController videoPlayerController;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    videoPlayerController = new VideoPlayerController.network(widget.url);

    _initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      //       Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });
  } // This closing tag was missing

  @override
  void dispose() {
    videoPlayerController.dispose();
    //    widget.videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return new Container(
            child: Card(
              key: new PageStorageKey(widget.url),
              elevation: 5.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Chewie(
                      key: new PageStorageKey(widget.url),
                      controller: ChewieController(
                        videoPlayerController: videoPlayerController,
                        aspectRatio: 3 / 2,
                        // Prepare the video to be played and display the first frame
                        autoInitialize: true,
                        looping: false,
                        autoPlay: false,
                        // Errors can occur for example when trying to play a video
                        // from a non-existent URL
                        errorBuilder: (context, errorMessage) {
                          return Center(
                            child: Text(
                              errorMessage,
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.redAccent,
            ),
          );
        }
      },
    );
  }
}
