import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:topfirebase/Loging_screen.dart';
import 'package:topfirebase/Utilis/Utilis.dart';


class Profile_Card extends StatefulWidget {
  const Profile_Card({
    super.key,
    this.enableOnTap = true,
  });

  final bool enableOnTap;

  @override
  State<Profile_Card> createState() => _Profile_CardState();
}

class _Profile_CardState extends State<Profile_Card> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _user = FirebaseFirestore.instance;




  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
      },
      leading: const CircleAvatar(
        child: Icon(Icons.person,color: Colors.white,),

      ),
      title: const Text(
        "Username",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700
        ),),
      subtitle: const Text(
        "User_Email",

        style: TextStyle(
            color: Colors.white
        ),),
      trailing: IconButton(
        onPressed: (){

        },
        icon: IconButton(
          onPressed: (){
            FirebaseAuth auth = FirebaseAuth.instance;
            auth.signOut().then((value){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login_Screen()), (route) => false);
              Utils().toastMessage("Logout Success");
            }).onError((error, stackTrace){
              Utils().toastMessage(error.toString());
            });


          },
            icon: Icon(Icons.logout,color: Colors.white,)),
      ),
      tileColor: Colors.blue,
    );
  }

}
