import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final User user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: StreamBuilder<Object>(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // var documents = snapshot.data.documents;
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (ctx, index) => Container(
                // child: Text(documents[index].get('text')),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chat')
              .snapshots()
              .listen((querySnapshot) {
            querySnapshot.docs.forEach((element) {
              print(element.get('text'));
            });
          });
        },
      ),
    );
  }
}
