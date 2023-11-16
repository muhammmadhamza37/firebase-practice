import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_practice/utils/utils.dart';
import 'package:firebase_practice/widgets/round_button.dart';
import 'package:flutter/material.dart';
class AddFireStoreDataScreen extends StatefulWidget {

  const AddFireStoreDataScreen({Key? key}) : super(key: key);

  @override
  State<AddFireStoreDataScreen> createState() => _AddFireStoreDataScreenState();
}

class _AddFireStoreDataScreenState extends State<AddFireStoreDataScreen> {

  final PostController = TextEditingController();
  bool loading = false;
  final fireStore= FirebaseFirestore.instance.collection('Hamza');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Firestore Data'),
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
                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  fireStore.doc(id).set({
                    'title': PostController.text.toString(),
                    'id' : id
                  }).then((value){
                    setState(() {
                      loading =false;
                    });
                    Utils().toastMessage('Post Added');
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
