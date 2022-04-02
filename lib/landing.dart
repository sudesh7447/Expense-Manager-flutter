// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:op/data.dart';
import 'package:op/home.dart';
import 'package:op/login.dart';
import 'package:op/signup.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 12),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                'Welcome to',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 29),
              ),
              Text(
                'Expense Tracker',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: SvgPicture.asset('assets/chat.svg'),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              RoundedButton(
                  text: "LOGIN",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  color: Color(0xFF6F35A5)),
              RoundedButton(
                  text: "SIGNUP",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  },
                  color: Color(0xFF6F35A5))
            ],
          ),
        ),
      ),
    );
  }
}
