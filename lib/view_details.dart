import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Edit_page.dart';

class ViewDetails extends StatelessWidget {
  ViewDetails({Key? key}) : super(key: key);

  late CollectionReference reference =
      FirebaseFirestore.instance.collection('Employee-Details');

  delete_data(index) async {
    DocumentReference ref = await FirebaseFirestore.instance
        .collection('Employee-Details')
        .doc(index);
    ref.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
          stream: reference.orderBy('Time', descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                QuerySnapshot querySnapshot = snapshot.data;
                List<QueryDocumentSnapshot> documents = querySnapshot.docs;
                List<Map> items = documents
                    .map((e) => {
                          'id': e.id.toString(),
                          'name': e['Name'],
                          'time': e['Time'],
                          'Active': e['active'],
                          'Years': e['years']
                        })
                    .toList();

                if (items.isNotEmpty) {
                  return SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text('EMPLOYEE NAME'),
                              Text('YEARS'),
                              Text('STATUS'),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                String name = items[index]['name'].toString();
                                String years = items[index]['Years'].toString();
                                String active =
                                    items[index]['Active'].toString();
                                String id = items[index]['id'];
                                return InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return WillPopScope(
                                              onWillPop: () =>
                                                  Future.value(false),
                                              child: Dialog(
                                                child: Container(
                                                    height: 200,
                                                    width: 200,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const Text(
                                                                'Emploee Details-',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              InkWell(
                                                                  onTap: () {
                                                                    delete_data(
                                                                        id);
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: const Icon(
                                                                      Icons
                                                                          .delete))
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Container(
                                                            height: 1,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            color: Colors.black,
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          RichText(
                                                            text: TextSpan(
                                                                text:
                                                                    'Employee name:  $name',
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16)),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                              'Tenured Employee:  $years (yrs)'),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          active == 'true'
                                                              ? const Text(
                                                                  'Status:  Active')
                                                              : const Text(
                                                                  'Status: Not-Active'),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              MaterialButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context,
                                                                          rootNavigator:
                                                                              true)
                                                                      .pop();
                                                                },
                                                                color:
                                                                    Colors.grey,
                                                                child: const Text(
                                                                    'CANCEL'),
                                                              ),
                                                              MaterialButton(
                                                                onPressed: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => Edit_page(
                                                                              employee_name: name,
                                                                              employee_years: years,
                                                                              employee_status: active,
                                                                              index: id)));
                                                                },
                                                                color: Colors
                                                                    .blueAccent,
                                                                child:
                                                                    const Text(
                                                                        'EDIT'),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            );
                                          });
                                    },
                                    child: active == 'true' &&
                                            int.parse(years) > 5
                                        ? Card(
                                            color: Colors.green,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.1,
                                                    height: 40,
                                                    child: Center(
                                                        child: RichText(
                                                      text: TextSpan(
                                                          text: name,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      20)),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ))),
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            10,
                                                    height: 40,
                                                    child: Center(
                                                        child: RichText(
                                                      text: TextSpan(
                                                          text: years,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      20)),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ))),
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3.9,
                                                    height: 40,
                                                    child: Center(
                                                        child: RichText(
                                                      text: const TextSpan(
                                                          text: 'Active',
                                                          style: TextStyle(
                                                              fontSize: 20)),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ))),
                                              ],
                                            ),
                                          )
                                        : Card(
                                            color: Colors.grey,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.1,
                                                    height: 40,
                                                    child: Center(
                                                        child: RichText(
                                                      text: TextSpan(
                                                          text: name,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black)),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ))),
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            10,
                                                    height: 40,
                                                    child: Center(
                                                        child: RichText(
                                                      text: TextSpan(
                                                          text: years,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black)),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ))),
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3.9,
                                                    height: 40,
                                                    child: Center(
                                                        child: RichText(
                                                      text: TextSpan(
                                                          text: active == 'true'
                                                              ? 'Active'
                                                              : 'Not-Active',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black)),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ))),
                                              ],
                                            ),
                                          ));
                              }),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('Add Employee data first to show here.'),
                  );
                }
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
