import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'data.dart';

class AddTodoDialogWidget extends StatefulWidget {
  @override
  _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  TextEditingController datecontroller = TextEditingController();
  TextEditingController Amountcontroller = TextEditingController();
  TextEditingController notecontroller = TextEditingController();
  TextEditingController typecontroller = TextEditingController();
  var type = '';
  startpush() {
    final validity = formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (validity) {
      formkey.currentState!.save();
      addtasktofirebase();
    } else {
      print("Not valid");
    }
  }

  addtasktofirebase() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User user = await auth.currentUser!;
    String uid = user.uid;
    var time = DateTime.now();
    await FirebaseFirestore.instance
        .collection('transactions')
        .doc(uid)
        .collection('mytransactions')
        .doc(time.toString())
        .set({
      'Date': datecontroller.text,
      'Value': Amountcontroller.text,
      'type': type,
      'note': notecontroller.text,
      'timestamp': time.toString(),
    });
    print('done');
    // Fluttertoast.showToast(msg: 'task added');
  }

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Add Transaction',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.cancel)),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  AddRoundedInputField(
                      Val: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2002),
                                lastDate: DateTime(2030))
                            .then((date) {
                          datecontroller.text =
                              date!.toUtc().toString().substring(0, 10);
                          print(datecontroller);
                        });
                      },
                      hintText: 'Select Date',
                      icon: Icons.calendar_month,
                      controller: datecontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'incorrect username';
                        } else {
                          return null;
                        }
                      }),
                  RoundedInputField(
                      hintText: 'Enter Amount',
                      icon: Icons.currency_rupee,
                      controller: Amountcontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'incorrect username';
                        } else {
                          return null;
                        }
                      }),
                  RoundedInputField(
                      hintText: 'Add Note',
                      icon: Icons.note,
                      controller: notecontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'incorrect username';
                        } else {
                          return null;
                        }
                      }),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        height: 35,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.redAccent),
                        child: TextButton(
                          onPressed: () async {
                            setState(() {
                              type = 'Expense';
                            });
                            await startpush();
                            Navigator.pop(context);
                            didChangeDependencies();
                          },
                          child: Text(
                            'Expense',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(right: 10),
                          height: 35,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.lightGreen),
                          child: TextButton(
                            onPressed: () async {
                              setState(() {
                                type = 'Income';
                              });

                              await startpush();
                              Navigator.pop(context);
                              didChangeDependencies();
                            },
                            child: Text(
                              'Income',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
