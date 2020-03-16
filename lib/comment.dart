import 'package:flutter/material.dart';

import 'model.dart';

const String _name = "Nguyễn Huy";

class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> with TickerProviderStateMixin {
  final List<ChatMessage> _message = <ChatMessage>[];
  final TextEditingController _textEditingController = new TextEditingController();
  bool _isComposing = false;
  ScrollController _controller;

  @override
  void dispose() {
    for (ChatMessage message in _message){
      message.animationController.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    ChatMessage message1 = ChatMessage(chat: Chat(name: "Hà Nguyễn", message: "Phim hay quá :v"), animationController: AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    ),);

    ChatMessage message2 = ChatMessage(chat: Chat(name: "Bá Linh", message: "App đẹp phim hay :v"), animationController: AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    ),);

    _message.insert(0, message1);
    message1.animationController.forward();

    _message.insert(0, message2);
    message2.animationController.forward();

    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener(){
    if(_controller.offset >= _controller.position.maxScrollExtent && !_controller.position.outOfRange){
      setState(() {

      });
    }

    if(_controller.offset <= _controller.position.minScrollExtent && !_controller.position.outOfRange){
      setState(() {

      });
    }
  }

  BoxDecoration myBoxDecoration(){
    return BoxDecoration(
      border: Border.all(width: 1.0, color: Colors.black38),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    );
  }

  Widget _buildTextInput(){
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.only(left: 8.0),
      decoration: myBoxDecoration(),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              cursorColor: Colors.amberAccent,
              style: TextStyle(color: Colors.amberAccent),
              controller: _textEditingController,
              onChanged: (String text){
                setState(() {
                  _isComposing = text.length > 0;
                });
              },
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              minLines: 1,
              decoration: InputDecoration.collapsed(
                  hintText: "Viết bình luận...",
                  hintStyle: TextStyle(fontSize: 13,color: Colors.amberAccent),
              ),
            ),
          ),

          Container(
            child: IconButton(
              icon: Icon(Icons.send, color: _isComposing? Colors.amberAccent: Colors.grey,),
              onPressed: _isComposing
                  ?() => _handleSubmitted(_textEditingController.text)
                  : null,
            ),
          ),


        ],
      ),
    );
  }

  Widget _buildTextComposer(){
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            child: IconButton(
              icon: Icon(Icons.photo_camera, color: Colors.amberAccent,),
              onPressed: _handleTouchOnCamera,
            ),
          ),

          Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            child: IconButton(
              icon: Icon(Icons.photo, color: Colors.amberAccent,),
              onPressed: _handleTouchOnGalleryPhoto,
            ),
          ),

          Expanded(
            child: _buildTextInput(),
          )
        ],
      ),
    );
  }

  void _handleSubmitted(String text){
    _textEditingController.clear();
    setState(() {
      _isComposing = false;
    });

    if(text.length >0){
      ChatMessage message = new ChatMessage(
        chat: Chat(name: _name, message: text),
        animationController: AnimationController(
          duration: Duration(milliseconds: 700),
          vsync: this,
        ),
      );
      setState(() {
        _message.insert(0, message);
      });
      message.animationController.forward();
    }
  }

  void _handleTouchOnCamera(){

  }

  void _handleTouchOnGalleryPhoto(){

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.black),
            child: SafeArea(
              bottom: true,
              child: _buildTextComposer(),
            ),
          ),

          Flexible(
            child: ListView.builder(
              controller: _controller,
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index)=> _message[index],
              itemCount: _message.length,
            ),
          ),


        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {

  Chat chat;
  final AnimationController animationController;

  ChatMessage({this.chat, this.animationController});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
          parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.amberAccent, width: 0.2)
          ),
          color: Colors.black,
        ),

        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 15.0),
              child: CircleAvatar(
                child: Text(chat.name[0]),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(chat.name, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Colors.amberAccent)),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(chat.message, style: TextStyle(fontSize: 11, color: Colors.white),),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 30.0, bottom: 8.0),
                      child: Text("Thích", style: TextStyle(color: Colors.grey, fontSize: 9.0),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 80.0, bottom: 8.0),
                      child: Text("Trả lời", style: TextStyle(color: Colors.grey, fontSize: 9.0),),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}