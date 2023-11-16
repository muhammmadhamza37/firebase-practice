import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_practice/ui/auth/login_screen.dart';
import 'package:firebase_practice/ui/posts/add_posts.dart';
import 'package:firebase_practice/utils/utils.dart';

import 'add_firestore_data.dart';
class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({Key? key}) : super(key: key);

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final auth = FirebaseAuth.instance ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FireStore'),
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>LoginScreen()));
            }).onError((error, stackTrace){
              Utils().toastMessage(error.toString());
            });
          }, icon: Icon(Icons.logout_outlined),),
          SizedBox(width: 10,)
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(itemBuilder: (context,index){
              return ListTile(
              title: Text('Hamza'),
              );

            }
             ),
              ),
        ],
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFireStoreDataScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
}
}
