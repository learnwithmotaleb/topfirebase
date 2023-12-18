import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:topfirebase/Profile_Card.dart';
import 'package:topfirebase/Utilis/Utilis.dart';

import 'Add_Post.dart';

class Dashboard_Screen extends StatefulWidget {
  const Dashboard_Screen({super.key});

  @override
  State<Dashboard_Screen> createState() => _Dashboard_ScreenState();
}

class _Dashboard_ScreenState extends State<Dashboard_Screen> {

  final ref = FirebaseDatabase.instance.ref("Post");
  var _searchinValue = TextEditingController();
  var _editController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ref.onValue.listen((event){
    //
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        body: Column(
        children: [
        Profile_Card(),

    // Expanded(
    //   child: StreamBuilder(
    //     stream: ref.onValue,
    //     builder: (context,AsyncSnapshot<DatabaseEvent>snapshot){
    //
    //       Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
    //       List<dynamic> list =[];
    //       list.clear();
    //       list = map.values.toList();
    //
    //       if(snapshot.hasData){
    //         return ListView.builder(
    //           itemCount: snapshot.data?.snapshot.children.length,
    //           itemBuilder: (context,index){
    //             return ListTile(
    //                 title:Text(list[index]['name']),
    //               subtitle: Text(list[index]['id'],),
    //             );
    //           },
    //         );
    //       }else{
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //
    //     },
    //
    //   ),
    // ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _searchinValue,
              onChanged: (String value){
                setState(() {

                });
              },
              decoration: InputDecoration(
                hintText: "Search",
                  suffixIcon: Icon(Icons.search),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),

                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )
              ),
            ),
          ),

    Expanded(
    child: FirebaseAnimatedList(
    query: ref,
    itemBuilder: (BuildContext context, DataSnapshot snapshot, animation,index){

      final title = snapshot.child('name').value.toString();
      if(_searchinValue.text.isEmpty){
        return ListTile(
          title: Text(snapshot.child('name').value.toString()),
          subtitle: Text(snapshot.child('id').value.toString()),
            trailing: PopupMenuButton(
                icon: Icon(Icons.more_vert),
                itemBuilder: (context)=>[
                  PopupMenuItem(
                      value: 1,
                      onTap: (){
                        showMyDialog(title, snapshot.child('id').value.toString());
                      },
                      child: ListTile(
                        leading: Icon(Icons.edit),
                        title: Text("Edit Item"),
                      )
                  ),
                  PopupMenuItem(
                      value: 2,
                      onTap: (){
                        ref.child(snapshot.child('id').value.toString()).remove().then((value){
                          Utils().toastMessage("Successful Delete");
                        }).onError((error, stackTrace){
                          Utils().toastMessage("Some Problem In Delete");
                        });
                      },
                      child: ListTile(
                        leading: Icon(Icons.delete),
                        title: Text("Delete Item"),
                      )
                  ),


                ]

            )
        );
      }else if(title.toLowerCase().contains(_searchinValue.text.toLowerCase().toString())){
        return ListTile(
          title: Text(snapshot.child('name').value.toString()),
          subtitle: Text(snapshot.child('id').value.toString()),
          trailing: PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (context)=>[
              PopupMenuItem(
                value: 1,
                  onTap: (){
                    showMyDialog(title,snapshot.child('id').value.toString());
                  },
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text("Edit"),
                  )
              ),
              PopupMenuItem(
                  value: 2,
                  onTap: (){
                    ref.child(snapshot.child('id').value.toString()).remove().then((value){
                      Utils().toastMessage("Successful Delete");
                    }).onError((error, stackTrace){
                      Utils().toastMessage("Some Problem In Delete");
                    });
                  },
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text("Delete Item"),
                  )
              ),


    ]

          ),
        );
      }else{
        return Container();
      }




    }


  )

  ,

  )

  ]

  ,

  )

  ,

  floatingActionButton

      :

  FloatingActionButton

  (

  onPressed: (){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPost_Screen()));
  },
  child: Icon(Icons.add),
  )

  ,

  )

  ,

  );
}
  Future<void> showMyDialog(String title, String id)async{
    _editController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Update'),
            content: Container(
              child: TextFormField(
                controller: _editController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Cancel")),
              TextButton(onPressed: (){
                Navigator.pop(context);
                ref.child(id).update({
                  'name':_editController.text.toString()
                }).then((value){
                  Utils().toastMessage("Successful Update");
                }).onError((error, stackTrace){
                  Utils().toastMessage(error.toString());
                });
              }, child: const Text("Update")),
            ],
          );
        }

    );
  }

}
