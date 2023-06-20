import 'package:chattest/ChatMessage.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController _textEditingController = TextEditingController();

  List<ChatMessage> _chat = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat App"),
      ),
      body: Column(
        children: [
          Expanded(child: ListView.builder(itemBuilder: (context, index) {
            return _chat[index];
          }, itemCount: _chat.length,)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(hintText: "메시지 입력창"),
                    //Function 형태가 같으면 이름만 넣으면 됨
                    onSubmitted: _handleSubmitted,
                    /*onSubmitted: (String text){
                      //Keypad 확인 버튼ㅅ
                      _handleSubmitted(_textEditingController.text);
                    },*/
                  ),
                ),
                SizedBox( 
                  width: 8.0,
                ),
                TextButton(onPressed: (){
                  //Send Button 눌렀을 때
                  _handleSubmitted(_textEditingController.text);
                },
                    child: Text("Send"),
                    style: TextButton.styleFrom(foregroundColor: Colors.amberAccent))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
   Logger().d(text);
   _textEditingController.clear();
  }
}
