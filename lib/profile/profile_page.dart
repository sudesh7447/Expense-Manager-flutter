import 'package:flutter/material.dart';
import 'package:op/profile/profile_body.dart';



class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding( padding: EdgeInsets.only(top: 50),child: Body()),
    );
  }
}