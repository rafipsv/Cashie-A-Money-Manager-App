// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_local_variable, avoid_print, prefer_final_fields, unused_field, unnecessary_null_comparison

import 'package:expense_manager/models/helpers.dart';
import 'package:expense_manager/pages/HomePage.dart';
import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  String label = "";
  String moneyHintText = "Enter Money";
  String noteHintText = "Enter Short Note";
  DateTime _dateTime = DateTime.now();
  TextEditingController _money = TextEditingController();
  TextEditingController _note = TextEditingController();
  Helper helper = Helper();

  /// this function is for showing datetime picker for user..
  void datePicker(BuildContext context) async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2012),
        lastDate: DateTime.now());
    if (date == null) {
      return;
    }
    setState(() {
      _dateTime = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          /// MediaQuery for fill all height and width of entire screen.
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff000428),
                Color(0xff004e92),
              ],
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 20.0),
              Text(
                "Add Transaction",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30.0,
                    color: Colors.white),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  Icon(
                    Icons.attach_money,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    /// textfield for accept user's money input
                    child: TextField(
                      controller: _money,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: moneyHintText,
                        hintStyle: TextStyle(
                            color: Color.fromARGB(234, 177, 172, 172)),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 25.0),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  Icon(
                    Icons.description,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    /// textfield for accept user's Short Note input
                    child: TextField(
                      controller: _note,
                      decoration: InputDecoration(
                        counterStyle: TextStyle(color: Colors.white),
                        hintText: noteHintText,
                        hintStyle: TextStyle(
                          color: Color.fromARGB(234, 177, 172, 172),
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 25.0),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  Icon(
                    Icons.source,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  SizedBox(
                    width: 10,
                  ),

                  /// ChoiceChips for user's event choice.
                  ChoiceChip(
                    label: Text(
                      "Income",
                      style: TextStyle(
                          color:
                              label == "Income" ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    disabledColor:
                        label == "Income" ? Colors.cyan : Colors.white,
                    selected: label == "Income" ? true : false,
                    selectedColor:
                        label == "Income" ? Colors.cyan : Colors.white,
                    // disabledColor: isChecked ? Colors.cyan : Colors.white,
                    onSelected: (val) {
                      setState(() {
                        label = "Income";
                      });
                    },
                  ),
                  SizedBox(
                    width: 40.0,
                  ),

                  /// ChoiceChips for user's event choice.
                  ChoiceChip(
                    label: Text(
                      "Expense",
                      style: TextStyle(
                          color:
                              label == "Expense" ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    disabledColor:
                        label == "Expense" ? Colors.cyan : Colors.white,
                    selected: label == "Expense" ? true : false,
                    selectedColor:
                        label == "Expense" ? Colors.cyan : Colors.white,
                    // disabledColor: isChecked ? Colors.cyan : Colors.white,
                    onSelected: (val) {
                      setState(() {
                        label = "Expense";
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40,
                  ),

                  /// For Execute DatePicker for user.
                  InkWell(
                    onTap: () {
                      datePicker(context);
                    },
                    child: Icon(
                      Icons.date_range,
                      color: Color.fromARGB(255, 33, 152, 173),
                      size: 30.0,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${_dateTime.day}/${_dateTime.month}/${_dateTime.year}",
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),

              /// Button For Push Data into Database.
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 29, 164, 168),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    if (int.parse(_money.text) != 0 &&
                        _note.text != "" &&
                        label != "") {
                      await helper.AddTodo(
                          int.parse(_money.text), _note.text, label, _dateTime);
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return HomePage();
                      }), (route) => false);
                    }
                  },
                  child: Text(
                    "Add",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
