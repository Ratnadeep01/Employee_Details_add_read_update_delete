import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Add_Details extends StatefulWidget {
  Add_Details({Key? key}) : super(key: key);

  @override
  State<Add_Details> createState() => _Add_DetailsState();
}

class _Add_DetailsState extends State<Add_Details> {
  final TextEditingController name_controller = TextEditingController();
  final TextEditingController years_controller = TextEditingController();
  bool _check = false;
  bool name_check = true;
  bool years_check = true;
  bool progress_button = false;

  add_video() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('Employee-Details');
    final phonefilename = <String, dynamic>{
      "Name": name_controller.text,
      "years": years_controller.text,
      "active": _check.toString(),
      "Time": DateTime.now().millisecondsSinceEpoch
    };
    await collectionRef.add(phonefilename);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Employee Details',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 50,
                    child: TextFormField(
                      onTap: () {
                        setState(() {
                          name_check = true;
                        });
                      },
                      controller: name_controller,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        errorText: name_check ? null : 'Please enter the name',
                        hintText: 'Name',
                        labelText: 'Enter name of the Employee',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 10),
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 50,
                    child: TextFormField(
                      onTap: () {
                        setState(() {
                          years_check = true;
                        });
                      },
                      controller: years_controller,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        hintText: 'Years',
                        labelText: 'Tenure-Years(completed)',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 10),
                        errorText:
                            years_check ? null : 'Please enter the years',
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Status of the Employee'),
                      Checkbox(
                          value: _check,
                          onChanged: (value) {
                            setState(() {
                              _check = !_check;
                            });
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                      'NOTE: (Status indicates whether the employee is active with the organization or not.)'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (name_controller.text.isNotEmpty &&
                            years_controller.text.isNotEmpty) {
                          try {
                            setState(() {
                              progress_button = true;
                            });
                            print(_check);
                            await add_video();
                            setState(() {
                              progress_button = false;
                            });
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Your Data has been uploaded to our database!!!',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    8,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  MaterialButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      years_controller.clear();
                                                      name_controller.clear();
                                                      _check = false;
                                                    },
                                                    color: Colors.grey,
                                                    child: const Text(
                                                        'FILL AGAIN'),
                                                  ),
                                                  MaterialButton(
                                                    onPressed: () {
                                                      Navigator.popUntil(
                                                          context,
                                                          (route) =>
                                                              route.isFirst);
                                                    },
                                                    color: Colors.blueAccent,
                                                    child: const Text('HOME'),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          } catch (e) {}
                          ;
                        } else if (name_controller.text.isEmpty &&
                            years_controller.text.isNotEmpty) {
                          setState(() {
                            name_check = false;
                          });
                        } else if (years_controller.text.isEmpty &&
                            name_controller.text.isNotEmpty) {
                          setState(() {
                            years_check = false;
                          });
                        } else if (name_controller.text.isEmpty &&
                            years_controller.text.isEmpty) {
                          setState(() {
                            name_check = false;
                            years_check = false;
                          });
                        }
                      },
                      child: progress_button
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 4,
                            ))
                          : const Text('SUBMIT'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
