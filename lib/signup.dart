// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 12),
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
              ),
              SizedBox(
                height: 1,
              ),
              RoundedInputField(
                hintText: 'Enter password',
                icon: Icons.password,
              ),
              SizedBox(
                height: 10,
              ),
              RoundedButton(
                text: 'Submit',
                press: () {},
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
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
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
    );
  }
}