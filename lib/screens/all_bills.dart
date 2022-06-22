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
                bills.add(BillModel.fromJson(data, element.id));
              }
            }
            return Container(
              padding: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: bills.length,
                  itemBuilder: (context, index) {
                    var bill = bills[index];
                    String status = bill.isPaid!
                        ? "Paid"
                        : DateTime.now()
                                .difference(bill.date!.toDate())
                                .isNegative
                            ? "Overdue"
                            : "Unpaid";

                    String user = bill.user!.last.toString().substring(2, 8);

                    var date = bill.date!.toDate();

                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (DismissDirection direction) {
                        FirebaseFirestore.instance
                            .collection('bills')
                            .doc(bill.id!)
                            .update({'isPaid': true});
                        setState(() {});
                      },
                      background: Icon(Icons.mark_email_read),
                      child: Container(
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
                              children: [
                                Text(
                                  "${bill.title}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Chip(
                                    backgroundColor: bill.isPaid!
                                        ? Colors.blueAccent
                                        : status == "Overdue"
                                            ? Color.fromARGB(255, 239, 132, 132)
                                            : Colors.greenAccent,
                                    label: Text(status))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${bill.category}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text("Kes. ${bill.amount}")
                              ],
                            ),
                            const Divider(
                              color: Colors.black,
                              thickness: 2.0,
                            ),
                            Text(
                                "$user by ${date.day}/${date.month}/${date.year}")
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }),
    );
  }
}
