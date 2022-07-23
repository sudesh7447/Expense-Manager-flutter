// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:op/add_ex.dart';
import 'package:op/landing.dart';

import 'profile/profile_page.dart';

User? user = FirebaseAuth.instance.currentUser;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? uid = user?.uid;
  int spending = 0;
  int income = 0;

  @override
  void initState() {
    getuid();
    super.initState();
  }

  getuid() async {
    final User? user = await FirebaseAuth.instance.currentUser;
    setState(() {
      uid = user!.uid;
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    FirebaseFirestore.instance
        .collection('transactions')
        .doc(uid)
        .collection('mytransactions')
        .get()
        .then((value) {
      print(value.docs.length);

      setState(() {
        income = 0;
        spending = 0;
      });
      for (int i = 0; i < value.docs.length; i++) {
        if (value.docs[i]['type'].toString() == 'Income') {
          income += int.parse(value.docs[i]['Value']);
        } else {
          spending += int.parse(value.docs[i]['Value']);
        }
      }
      setState(() {
        income = income;
        spending;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            margin: EdgeInsets.only(top: 12),
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good Morning',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF3A3A3A)),
                            ),
                            Text('Amanda Alex',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF3A3A3A)))
                          ],
                        ),
                      ),
                      GestureDetector(
                        // onTap: () async {
                        //   await FirebaseAuth.instance.signOut();
                        //   Navigator.of(context).pushAndRemoveUntil(
                        //       MaterialPageRoute(
                        //           builder: (context) => Landing()),
                        //       (Route<dynamic> route) => false);
                        // },
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfileScreen()),
                          );
                        },
                        child: Container(
                          height: 59,
                          width: 59,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Text(
                        'This Month',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF3A3A3A),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 25.0),
                      child: Icon(
                        CupertinoIcons.money_dollar_circle_fill,
                        color: Color(0xFF1E1E99),
                        size: 36.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 60,
                      width: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.redAccent),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            CupertinoIcons.arrow_up_circle,
                            color: Colors.white,
                            size: 50.0,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Spending',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                              Text(
                                '₹' + spending.toString(),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 60,
                      width: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.lightGreen),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            CupertinoIcons.arrow_down_circle,
                            color: Colors.white,
                            size: 50.0,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Income',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                              Text(
                                '₹' + income.toString(),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 13, top: 39),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent transactions',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF3A3A3A)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Center(
                          child: Container(
                            height: 30,
                            width: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Color(0xFF1E1E99)),
                            child: Center(
                              child: Text(
                                'See All',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('transactions')
                        .doc(uid)
                        .collection('mytransactions')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        final docData = snapshot.data!.docs;
                        final len = docData.length;

                        return ListView.builder(
                          // reverse: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemCount: min(docData.length, 5),
                          itemBuilder: (context, index) {
                            return Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons
                                            .arrow_up_arrow_down_circle_fill,
                                        color:docData[len - index - 1]['type'] == 'Income' ? Colors.lightGreen : Colors.redAccent,
                                        size: 45.0,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "₹" +
                                                docData[len - index - 1]
                                                    ['Value'],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFF3A3A3A)),
                                          ),
                                          Text(
                                            docData[len - index - 1]['type'],
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF3A3A3A)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        docData[len - index - 1]['Date']
                                            .toString()
                                            .substring(0, 10),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF3A3A3A)),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      GestureDetector(
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 26,
                                        ),
                                        onTap: () async {
                                          await FirebaseFirestore.instance
                                              .collection('transactions')
                                              .doc(uid)
                                              .collection('mytransactions')
                                              .doc(docData[len - index - 1]
                                                  ['timestamp'])
                                              .delete();
                                          print(docData[len - index - 1]
                                              ['timestamp']);
                                          didChangeDependencies();
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                              height: 70,
                              margin: EdgeInsets.only(bottom: 13),
                              padding: EdgeInsets.only(
                                  left: 24, top: 12, bottom: 12, right: 22),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                    color: Color(0x10000000),
                                  ),
                                ],
                              ),
                            );
                          },
                          padding: EdgeInsets.only(left: 16, right: 16),
                          shrinkWrap: true,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),


          Positioned(
            right: 30,
            bottom: 19,
            child: FloatingActionButton(
              backgroundColor: Color(0xFF1E1E99),
              onPressed: () => showDialog(
                context: context,
                builder: (context) => AddTodoDialogWidget(),
                barrierDismissible: false,
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
