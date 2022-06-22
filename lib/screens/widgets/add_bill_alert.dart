import 'package:billed/models/bill_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddBillAlert extends StatefulWidget {
  const AddBillAlert({Key? key}) : super(key: key);

  @override
  State<AddBillAlert> createState() => _AddBillAlertState();
}

class _AddBillAlertState extends State<AddBillAlert> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _categoryFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  void pickTime() async {
    final DateTime? dt = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.parse("3000-12-31"));
    if (dt != null) {
      setState(() {
        _dateController.text = dt.toString();
      });
    }
  }

  void _addBill(BuildContext context) {
    //Add Bill to Firestore
    if (_amountController.text.isNotEmpty &&
        _dateController.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        _categoryController.text.isNotEmpty) {
      BillModel bill = BillModel(
          amount: _amountController.text,
          title: _nameController.text,
          category: _categoryController.text,
          user: FirebaseAuth.instance.currentUser!.uid);
      FirebaseFirestore.instance
          .collection("bills")
          .add(bill.toMap())
          .then((value) => Navigator.of(context).pop());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please fill all the fields"),
      ));
    }
  }

  void pickCategory() async {
    showModalBottomSheet(
        context: context,
        builder: (_) => Container(
              padding: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
              child: ListView(
                children: [
                  const Text(
                    "Select Category",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 2.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _categoryController.text = "Food";
                      });
                      Navigator.pop(context);
                    },
                    
                    child: Row(
                      children: const [
                        Icon(
                          Icons.dining_rounded,
                          color: Colors.greenAccent,
                          size: 32,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Food",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _categoryController.text = "Utilities";
                      });
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.document_scanner,
                          color: Colors.amberAccent,
                          size: 32,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Utilities",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _categoryController.text = "Transport";
                      });
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.fire_truck,
                          color: Colors.blueAccent,
                          size: 32,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Transport",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _categoryController.text = "Entertainment";
                      });
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.video_collection,
                          color: Colors.redAccent,
                          size: 32,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Entertainment",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Bill"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              focusNode: _nameFocusNode,
              controller: _nameController,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.description),
                labelText: "Bill Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              focusNode: _amountFocusNode,
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.numbers),
                labelText: "Bill Amount",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              onTap: pickTime,
              focusNode: _dateFocusNode,
              controller: _dateController,
              keyboardType: TextInputType.none,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.calendar_month),
                labelText: "Due Date",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              onTap: pickCategory,
              focusNode: _categoryFocusNode,
              controller: _categoryController,
              keyboardType: TextInputType.none,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.category_outlined),
                labelText: "Category",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text("Add"),
          onPressed: () => _addBill(context),
        ),
      ],
    );
  }
}
