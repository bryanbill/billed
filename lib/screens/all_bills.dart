import 'package:billed/models/bill_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AllBills extends StatefulWidget {
  const AllBills({Key? key}) : super(key: key);

  @override
  State<AllBills> createState() => _AllBillsState();
}

class _AllBillsState extends State<AllBills> {
  final Stream<QuerySnapshot> _billsStream = FirebaseFirestore.instance
      .collection('bills')
      .where("user", arrayContains: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("All Bills")),
      body: StreamBuilder<QuerySnapshot>(
          stream: _billsStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            }
            List<BillModel> bills = [];
            if (snapshot.hasData) {
              for (var element in snapshot.data!.docs) {
                var data = element.data() as Map<String, dynamic>;
                bills.add(BillModel.fromJson(data));
              }
            }
            return Container(
              padding: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: bills.length,
                  itemBuilder: (context, index) => Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 243, 233, 237)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Food and Beverage",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Chip(
                                    backgroundColor:
                                        Color.fromARGB(255, 239, 132, 132),
                                    label: Text("Overdue"))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Food",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text("Kes. 23,000")
                              ],
                            ),
                            const Divider(
                              color: Colors.black,
                              thickness: 2.0,
                            ),
                            const Text("John Doe by 5th July, 2022")
                          ],
                        ),
                      )),
            );
          }),
    );
  }
}
