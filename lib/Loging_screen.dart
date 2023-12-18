import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:topfirebase/Dashboard_Screen.dart';
import 'package:topfirebase/Signup_screen.dart';
import 'package:topfirebase/Utilis/Utilis.dart';

import 'login_with_phone.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  GlobalKey<FormState> _forKey = GlobalKey<FormState>();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool isLoading = false;
  bool isLoadingWithPhone = false;

  
  void login(){
    if (_forKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      _firebaseAuth.signInWithEmailAndPassword(email: _emailController.text.toString(), password: _passwordController.text.toString()).then((value) {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard_Screen()));
        Utils().toastMessage(value.user!.email.toString());
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  SizedBox(height: 40,),
                  Container(
                    height: 200,
                    child: Lottie.asset(
                        "assets/lottie/Animation - 1702408480975.json"),
                  ),
                  SizedBox(
                    height: 20,
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
                          hintText: "*********",
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
                      onTap: login,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue,
                        ),
                        height: 50,
                        child: Center(child: Text("Login",style: TextStyle(
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
                      Text("Don't have an account!"),
                      SizedBox(width: 10,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Signup_Screen()));
                        },
                        child: Text("SignUp",style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),),
                      ),


                    ],
                  ),
                  SizedBox(height: 30,),
                  Visibility(
                    visible: isLoadingWithPhone == false,
                    replacement: Center(child: CircularProgressIndicator(),),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginWithPhone()));
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.phone,color: Colors.white,),
                              SizedBox(width: 10,),
                              Text('Login with phone',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white
                              ),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
