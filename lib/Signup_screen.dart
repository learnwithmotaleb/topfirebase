import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:topfirebase/Loging_screen.dart';
import 'package:topfirebase/Utilis/Utilis.dart';

class Signup_Screen extends StatefulWidget {
  const Signup_Screen({
    super.key,
  });

  @override
  State<Signup_Screen> createState() => _Signup_ScreenState();
}

class _Signup_ScreenState extends State<Signup_Screen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  GlobalKey<FormState> _forKey = GlobalKey<FormState>();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool isLoading = false;

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
          title: Text("Sign Up"),
          centerTitle: true,
        ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _forKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    child: Lottie.asset(
                        "assets/lottie/Animation - 1702408480975.json"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Valid Name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Full Name",
                        prefixIcon: Icon(Icons.title),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Valid Email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: "example@gmail.com",
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter password!";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: "****************",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))
                      )
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: isLoading == false,
                    replacement: Center(child: CircularProgressIndicator(),),
                    child: GestureDetector(
                      onTap: signup,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue,
                        ),
                        height: 50,
                        child: Center(child: Text("SignUp",style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                        ),)),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account!"),
                      SizedBox(width: 10,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Login_Screen()));
                        },
                        child: Text("Login",style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),),
                      ),


                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void signup(){
    if (_forKey.currentState!.validate()) {

      setState(() {
        isLoading = true;
      });

      _firebaseAuth.createUserWithEmailAndPassword(
        email: _emailController.text.toString(),
        password: _passwordController.text.toString(),
      ).then((value){

        FirebaseFirestore.instance.collection("user").doc().set(
          {
            'UserName': _nameController.text.toString(),
            'E-mail': _emailController.text.toString(),
            'Password': _passwordController.text.toString(),
          }
        );

        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login_Screen()));

        setState(() {
          isLoading = false;
        });

      }).onError((error, stackTrace){
        Utils().toastMessage(error.toString());
        debugPrint(error.toString());
        setState(() {
          isLoading = false;
        });
      });

    }
  }
}
