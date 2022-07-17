// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:op/data.dart';
import 'package:op/home.dart';
import 'package:op/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  startauth() {
    final validity = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (validity) {
      _formkey.currentState!.save();
      submitform(emailcontroller.text, passwordcontroller.text);
      print('hoho');
      print(emailcontroller.text);
    }
  }

  submitform(String email, String password) async {
    final auth = FirebaseAuth.instance;
    UserCredential authResult;
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 12),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: SvgPicture.asset('assets/signup.svg'),
                ),
                SizedBox(
                  height: 50,
                ),
                RoundedInputField(
                  hintText: 'Enter email',
                  icon: Icons.email,
                  controller: emailcontroller,
                  validator: (value) {
                    if (value!.isEmpty ||
                        ((!value.contains('@')) || (!value.contains('.com')))) {
                      return 'incorrect email';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 1,
                ),
                RoundedInputField(
                  hintText: 'Enter password',
                  icon: Icons.password,
                  controller: passwordcontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'incorrect username';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                RoundedButton(
                  text: 'Submit',
                  press: () async {
                    await startauth();
                    // setState(() {});
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  },
                  color: Color(0xFF6F35A5),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account , ',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6F35A5)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
