

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:topfirebase/Dashboard_Screen.dart';
import 'package:topfirebase/Utilis/Utilis.dart';

class AddPost_Screen extends StatefulWidget {
  const AddPost_Screen({super.key});

  @override
  State<AddPost_Screen> createState() => _AddPost_ScreenState();
}

class _AddPost_ScreenState extends State<AddPost_Screen> {
  bool isLoading = false;
  var _addPosting = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final databaseRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              alignment: Alignment.topLeft,
              child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: (){
                    Navigator.pop(context);
                  },child: Icon(Icons.arrow_back_ios,color: Colors.black,))),
        ),
        title: const Text("Add Task"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _globalKey,
            child: Column(
              children: [

                SizedBox(height: 30,),
                TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _addPosting,
                    maxLines: 4,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Some Text";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "What is in your mind?",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))
                    )
                ),
                SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: isLoading == false,
                  replacement: const Center(child: CircularProgressIndicator(),),
                  child: GestureDetector(
                    onTap: (){
                      if(_globalKey.currentState!.validate()){
                        setState(() {
                          isLoading= true;
                        });
                        String id = DateTime.now().millisecondsSinceEpoch.toString();

                        databaseRef.child(id).set({
                          "id":id,
                          "name": _addPosting.text.toString(),

                        }).then((value){
                          setState(() {
                            isLoading= false;
                          });
                          Utils().toastMessage("Post upload completed!");
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard_Screen()));
                        }).onError((error, stackTrace){
                          setState(() {
                            isLoading= false;
                          });
                          Utils().toastMessage(error.toString());
                        });



                      }


                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue,
                      ),
                      height: 50,
                      child: Center(child: Text("Post",style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),)),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }



}
