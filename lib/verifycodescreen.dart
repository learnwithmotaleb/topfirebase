import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:topfirebase/Dashboard_Screen.dart';

import 'Utilis/Utilis.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationID;
  const VerifyCodeScreen({required this.verificationID,super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool isLoading =false;
  final _verifyCode = TextEditingController();
  GlobalKey<FormState> _forKey = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _forKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50,),
                  Center(
                    child: Container(
                      height: 200,
                      child: Lottie.asset(
                          "assets/lottie/Animation - 1702408480975.json"),
                    ),
                  ),
                  SizedBox(height: 50,),
                  TextFormField(
              
                      controller: _verifyCode,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Valid Code";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          hintText: "1 to 6",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))
                      )
                  ),
                  SizedBox(height: 20,),
                  Visibility(
                    visible: isLoading == false,
                    replacement: Center(child: CircularProgressIndicator(),),
                    child: GestureDetector(
                      onTap: () async {
                        if (_forKey.currentState!.validate()){
                          setState(() {
                            isLoading = true;
                          });

                          final credential =PhoneAuthProvider.credential(
                              verificationId:widget.verificationID.toString(),
                              smsCode: _verifyCode.text.toString(),
                          );
                          try{
                            await auth.signInWithCredential(credential);
                            if (mounted) {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const Dashboard_Screen()));

                            }

                          }catch(e){
                            debugPrint(e.toString());
                            setState(() {
                              isLoading = false;
                            });
                            Utils().toastMessage(e.toString());
                          }



                        }
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue,
                        ),
                        height: 50,
                        child: Center(child: Text("Verify",style: TextStyle(
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
      ),
    );
  }
}
