import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_practice/utils/utils.dart';
import 'package:firebase_practice/widgets/round_button.dart';
import 'package:flutter/material.dart';
class AddPostsScreen extends StatefulWidget {

  const AddPostsScreen({Key? key}) : super(key: key);

  @override
  State<AddPostsScreen> createState() => _AddPostsScreenState();
}

class _AddPostsScreenState extends State<AddPostsScreen> {

  bool loading=false;
  final PostController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 30,),
            TextFormField(
              maxLines: 4,
              controller: PostController,
              decoration: (
            InputDecoration(
              hintText: 'What is  in your mind',
              border: OutlineInputBorder(),
            )
            ),
            ),
            SizedBox
              (height: 30,),
            RoundButton(title: 'Add',
                loading: loading,
                onTap: (){
              setState(() {
                loading =true;
              });

              databaseRef.child(DateTime.now().millisecondsSinceEpoch.toString()).set({
                'title' : PostController.text.toString() ,
                'id'    : DateTime.now().millisecondsSinceEpoch.toString()
              }).then((value){
                setState(() {
                  loading =false;
                });
                Utils().toastMessage('post added');
              }).onError((error, stackTrace){
                setState(() {
                  loading =false;
                });
                Utils().toastMessage(error.toString());
              });

              })
          ],

        ),
      ),
    );
  }
}
