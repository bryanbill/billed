import 'package:billed/models/bill_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
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
  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();
  List<DropDownValueModel> options = [];

  @override
  void initState() {
    super.initState();
    getFriends();
  }

  Future<List<DropDownValueModel>> getFriends() async {
    //Get all friends
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("friends")
        .get()
        .then((value) {
      for (var element in value.docs) {
        var data = element.data();
        options.add(DropDownValueModel(
          value: data["user"],
          name: data["user"].toString().substring(3, 7),
        ));
      }
    });
    return options;
  }

  final SingleValueDropDownController _controller =
      SingleValueDropDownController();

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
            bills.sort((a, b) => b.date!.compareTo(a.date!));
            return Container(
              padding: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height,
              child: bills.isEmpty
                  ? const Center(
                      child: Text("Nothing here"),
                    )
                  : ListView.builder(
                      itemCount: bills.length,
                      itemBuilder: (context, index) {
                        var bill = bills[index];
                        String status = bill.isPaid!
                            ? "Paid"
                            : bill.date!
                                    .toDate()
                                    .difference(DateTime.now())
                                    .isNegative
                                ? "Overdue"
                                : "Unpaid";

                        String user =
                            bill.user!.last.toString().substring(2, 8);

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
                          background: const Icon(Icons.mark_email_read),
                          child: GestureDetector(
                            onTap: () => showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      title: const Text("Share with"),
                                      content: DropDownTextField(
                                        clearOption: false,
                                        singleController: _controller,
                                        textFieldFocusNode: textFieldFocusNode,
                                        searchFocusNode: searchFocusNode,
                                        dropDownItemCount: 8,
                                        searchShowCursor: false,
                                        enableSearch: true,
                                        searchKeyboardType:
                                            TextInputType.number,
                                        dropDownList: options,
                                        onChanged: (val) {},
                                      ),
                                      actions: [
                                        TextButton(
                                          child: const Text("Share"),
                                          onPressed: () {
                                            if (_controller.dropDownValue ==
                                                null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Please select a friend"),
                                                duration: Duration(seconds: 2),
                                              ));
                                            } else {
                                              FirebaseFirestore.instance
                                                  .collection("bills")
                                                  .doc(bill.id)
                                                  .update({
                                                "user": FieldValue.arrayUnion([
                                                  _controller
                                                      .dropDownValue!.value
                                                ])
                                              });
                                              Navigator.of(context).pop();
                                            }
                                          },
                                        )
                                      ],
                                    )),
                            child: Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 246, 242, 243)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                  ? const Color.fromARGB(
                                                      255, 239, 132, 132)
                                                  : Colors.greenAccent,
                                          label: Text(status))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${bill.category}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[700],
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
                          ),
                        );
                      }),
            );
          }),
    );
  }
}
