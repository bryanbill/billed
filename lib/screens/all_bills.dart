import 'package:flutter/material.dart';

class AllBills extends StatefulWidget {
  const AllBills({Key? key}) : super(key: key);

  @override
  State<AllBills> createState() => _AllBillsState();
}

class _AllBillsState extends State<AllBills> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("All Bills"), actions: []),
      body: Container(padding: EdgeInsets.all(10)),
    );
  }
}
