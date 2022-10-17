import 'package:employee_record_system/view_details.dart';
import 'package:flutter/material.dart';

import 'add_details.dart';

class Home_Page extends StatelessWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Employee Details',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Add_Details()));
                        },
                        icon: Icon(
                          Icons.add,
                          size: 50,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Add'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewDetails()));
                        },
                        icon: const Icon(
                          Icons.library_add,
                          size: 50,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('View DataBase'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
