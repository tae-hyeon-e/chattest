import 'package:chattest/chatting/chat/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('time',descending: true)
            .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

    if (snapshot.hasError)
      return const Text('Firestore snapshot has error..');
    if (!snapshot.hasData)
      return const Text('Firestore snapshot isloading..');
    if (snapshot.data == null) {
      return const Text("Snapshot.data is null..");
    } else {
          final chatDocs = snapshot.data!.docs;
          return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (context, index) {
              return Container(
                child: ChatBubbles(
                  chatDocs[index].data()['text'],
                  chatDocs[index].data()['userId'].toString() == user!.uid,
                  chatDocs[index].data()['userName'].toString(),
                ),
              );
            },
          );
        }
      },
    );
  }
}
