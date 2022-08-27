// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, unnecessary_import, unused_local_variable, unnecessary_string_interpolations, await_only_futures

import 'dart:ui';

import 'package:expense_manager/models/helpers.dart';
import 'package:expense_manager/pages/add_transaction.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Helper helper = Helper();
  int totalBalance = 0;
  int totalExpense = 0;
  Box box = Hive.box<Map>("money");

  @override
  void initState() {
    super.initState();
    getDetails(box.toMap(), box.length);
  }

  getDetails(Map data, int len) {
    totalBalance = 0;
    totalExpense = 0;
    data.forEach((key, value) {
      if (value['type'] == "Income") {
        totalBalance = totalBalance + value['money'] as int;
      } else {
        totalBalance = totalBalance - value['money'] as int;
        totalExpense = totalExpense + value['money'] as int;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    /// safe area for unwanted pixel issues.
    return SafeArea(
      child: Scaffold(
        /// floating action button for push into our add transaction page.
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AddTransaction();
                },
              ),
            ).whenComplete(() {
              setState(() {});
            });
          },
          child: Icon(
            Icons.add,
            size: 30.0,
          ),
          backgroundColor: Color(0xffd63b7e),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ListView(children: [
          Container(
            /// MediaQuery for fill all height and width of entire screen.
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff42275a),
                  Color(0xff734b6d),
                ],
              ),
            ),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        /// used This avater for user image.
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage: AssetImage(
                            "images/user_emoji.jpg",
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Welcome User",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    /// iconButton for push into add transaction page.
                    IconButton(
                      padding: EdgeInsets.only(right: 10.0),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return AddTransaction();
                            },
                          ),
                        ).whenComplete(
                          () {
                            setState(() {});
                          },
                        );
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffddd6f3),
                      Color(0xfffaaca8),
                    ],
                  ),
                ),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Icon(
                          Icons.arrow_upward,
                          size: 30,
                          color: Color.fromARGB(255, 10, 209, 17),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Total Balance",
                            style: TextStyle(
                              color: Color.fromARGB(255, 29, 139, 33),
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            totalBalance.toString(),
                            style: TextStyle(
                              color: Color.fromARGB(255, 29, 139, 33),
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 10),
                        child: Icon(
                          Icons.arrow_downward,
                          size: 30,
                          color: Color.fromARGB(255, 172, 24, 13),
                        ),
                      ),
                      Column(children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Total Expense",
                          style: TextStyle(
                            color: Color.fromARGB(255, 172, 24, 13),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          totalExpense.toString(),
                          style: TextStyle(
                            color: Color.fromARGB(255, 172, 24, 13),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  )
                ]),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                child: ValueListenableBuilder(
                    valueListenable: Hive.box<Map>('money').listenable(),
                    builder: ((context, Box box, _) {
                      if (box.isEmpty) {
                        return Center(
                          child: Text(
                            "No Data Available",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 197, 33, 33)),
                          ),
                        );
                      }
                      getDetails(box.toMap(), box.length);
                      return ListView.builder(
                          itemCount: box.length,
                          itemBuilder: (context, index) {
                            var data = box.getAt(index);
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: InkWell(
                                onLongPress: () {
                                  box.deleteAt(index);
                                  getDetails(box.toMap(), box.length);
                                  setState(() {});
                                },
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  color: Color(0xffee9ca7),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        data['type'] == "Income"
                                            ? Icon(
                                                Icons.arrow_upward,
                                                color: Color.fromARGB(
                                                    255, 10, 129, 103),
                                                size: 30,
                                              )
                                            : Icon(
                                                Icons.arrow_downward,
                                                color: Color.fromARGB(
                                                    255, 197, 33, 33),
                                                size: 30,
                                              ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            data['type'] == 'Income'
                                                ? Text(
                                                    data['note'],
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Color.fromARGB(
                                                          255, 10, 129, 103),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  )
                                                : Text(
                                                    data['note'],
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Color.fromARGB(
                                                          255, 197, 33, 33),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                            data['type'] == 'Income'
                                                ? Text(
                                                    DateFormat.yMd()
                                                        .format(data['date']),
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color.fromARGB(
                                                          255, 112, 98, 98),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  )
                                                : Text(
                                                    DateFormat.yMd()
                                                        .format(data['date']),
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color.fromARGB(
                                                          255, 112, 98, 98),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 150),
                                          child: data['type'] == 'Income'
                                              ? Text(
                                                  data['money'].toString(),
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color.fromARGB(
                                                        255, 10, 129, 103),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                )
                                              : Text(
                                                  '-${data['money'].toString()}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color.fromARGB(
                                                        255, 197, 33, 33),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    })),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
