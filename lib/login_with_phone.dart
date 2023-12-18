import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:topfirebase/Utilis/Utilis.dart';
import 'package:topfirebase/verifycodescreen.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  final _phoneNumber = TextEditingController();
  final GlobalKey<FormState> _forKey = GlobalKey<FormState>();
  bool isLoading = false;

  final FirebaseAuth auth = FirebaseAuth.instance;

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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ))),
        ),
        title: Text("Phone Auth"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _forKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: 200,
                    child: Lottie.asset(
                        "assets/lottie/Animation - 1702408480975.json"),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                    controller: _phoneNumber,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Valid Number!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        hintText: "+88 012 3456 789",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)))),
                SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: isLoading == false,
                  replacement: Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if (_forKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        auth.verifyPhoneNumber(
                            phoneNumber: _phoneNumber.text.toString(),
                            verificationCompleted: (_) {
                              setState(() {
                                isLoading = false;
                              });
                            },
                            verificationFailed: (e) {
                              setState(() {
                                isLoading = false;
                              });
                              Utils().toastMessage(e.toString());
                            },
                            codeSent: (String verificationID, int? token){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VerifyCodeScreen(verificationID: verificationID,)));
                              setState(() {
                                isLoading = false;
                              });
                            },
                            codeAutoRetrievalTimeout: (e) {
                              Utils().toastMessage(e.toString());
                              setState(() {
                                isLoading = false;
                              });
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
                      child: Center(
                          child: Text(
                        "Send Code",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      )),
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
