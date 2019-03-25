import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/view/chat_message.dart';
import 'package:flutter/cupertino.dart';

class ChatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChatPageState();
  }
}

/**
 *
 */
class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final TextEditingController _textEditingController =
      new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  bool _isComposing = false;

  final ThemeData kIOSTheme = new ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.grey[100],
    primaryColorBrightness: Brightness.light,
  );

  final ThemeData kDefaultTheme = new ThemeData(
    primarySwatch: Colors.purple,
    accentColor: Colors.orangeAccent[400],
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: 'chat',
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text("chatPage"),
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        ),
        body: Container(
            child: Column(
              children: <Widget>[
                Flexible(
                  child: ListView.builder(
                    itemBuilder: (_, int index) => _messages[index],
                    padding: EdgeInsets.all(8.0),
                    reverse: false,
                    itemCount: _messages.length,
                  ),
                ),
                Divider(
                  height: 1.0,
                ),
                Container(
                  decoration: BoxDecoration(color: Theme.of(context).cardColor),
                  child: _buildTextComposer(),
                ),
              ],
            ),
            decoration: Theme.of(context).platform == TargetPlatform.iOS //new
                ? new BoxDecoration(
                    //new
                    border: new Border(
                      //new
                      top: new BorderSide(color: Colors.grey[200]), //new
                    ), //new
                  ) //new
                : null),
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _textEditingController,
                  onChanged: (String text) {
                    setState(() {
                      _isComposing = text.length > 0;
                    });
                  },
                  onSubmitted: _handleSubmitted,
                  decoration: InputDecoration.collapsed(hintText: "发送消息"),
                ),
              ),
              Container(
                // 发送
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? CupertinoButton(
                        child: Text("发送"),
                        onPressed: _isComposing
                            ? () => // 内容为空時不发送
                                _handleSubmitted(_textEditingController.text)
                            : null)
                    : CupertinoButton(
                  child: Icon(Icons.send),
                    onPressed: _isComposing
                        ? () => // 内容为空時不发送
                    _handleSubmitted(_textEditingController.text)
                        : null),
              ),
            ],
          )),
    );
  }

  void _handleSubmitted(String text) {
    _textEditingController.clear();
    setState(() {
      _isComposing = false;
    });
    ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 700)),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
