import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Edit_page extends StatefulWidget {
  String employee_name;
  String employee_years;
  String employee_status;
  String index;
  Edit_page(
      {Key? key,
      required this.employee_name,
      required this.employee_years,
      required this.employee_status,
      required this.index})
      : super(key: key);
  @override
  State<Edit_page> createState() => _Edit_pageState();
}

class _Edit_pageState extends State<Edit_page> {
  late TextEditingController _name;
  late TextEditingController _yrs;
  bool check_name = true;
  bool check_yrs = true;

  @override
  void initState() {
    _name = TextEditingController(text: widget.employee_name);
    _yrs = TextEditingController(text: widget.employee_years);
    _name.text = widget.employee_name;
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _yrs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _check;
    widget.employee_status == 'true' ? _check = true : _check = false;

    update_data() async {
      DocumentReference ref = await FirebaseFirestore.instance
          .collection('Employee-Details')
          .doc(widget.index);
      ref.update({
        'Name': _name.text,
        'active': _check.toString(),
        'years': _yrs.text
      });
    }

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Edit Employee Details-',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  onTap: () {
                    setState(() {
                      check_name = true;
                    });
                  },
                  controller: _name,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    errorText: check_name ? null : 'Please enter the name',
                    hintText: 'Enter the name of the Employee',
                    labelText: 'Employee-name',
                    hintStyle:
                        TextStyle(fontSize: 13.8, color: Colors.grey[700]),
                    labelStyle: const TextStyle(fontSize: 18),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  onTap: () {
                    setState(() {
                      check_yrs = true;
                    });
                  },
                  controller: _yrs,
                  keyboardType: TextInputType.phone,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    errorText: check_yrs ? null : 'Please enter the years',
                    hintText: 'Tenure of the Employee till now',
                    labelText: 'Tenure-Years(completed)',
                    hintStyle:
                        TextStyle(fontSize: 13.8, color: Colors.grey[700]),
                    labelStyle: TextStyle(fontSize: 18),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Status of the Employee'),
                    Checkbox(
                        value: _check,
                        onChanged: (value) {
                          setState(() {
                            widget.employee_status == 'true'
                                ? widget.employee_status = 'false'
                                : widget.employee_status = 'true';
                          });
                        })
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'NOTE: (Status indicates whether the employee is active with the organization or not.)'),
                SizedBox(height: MediaQuery.of(context).size.height / 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('CANCEL'),
                      color: Colors.grey,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        if (_name.text.isNotEmpty && _yrs.text.isNotEmpty) {
                          await update_data();
                          int count = 0;
                          Navigator.popUntil(context, (route) => count++ == 2);
                        }
                        if (_name.text.isEmpty && _yrs.text.isNotEmpty) {
                          setState(() {
                            check_name = false;
                            check_yrs = true;
                          });
                        }
                        if (_name.text.isNotEmpty && _yrs.text.isEmpty) {
                          setState(() {
                            check_name = true;
                            check_yrs = false;
                          });
                        }
                        if (_name.text.isEmpty && _yrs.text.isEmpty) {
                          setState(() {
                            check_name = false;
                            check_yrs = false;
                          });
                        }
                      },
                      child: Text('UPDATE'),
                      color: Colors.blue,
                    )
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
