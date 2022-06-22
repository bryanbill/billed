import 'package:billed/models/bill_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

List<Widget> recents(List<QueryDocumentSnapshot> docs) {
  List<Widget> widgets = [];

  List<BillModel> bills = [];
  for (var element in docs) {
    var data = element.data() as Map<String, dynamic>;
    bills.add(BillModel.fromJson(data));
  }

  for (BillModel bill in bills) {
    var date = bill.date!.toDate();
    widgets.add(ListTile(
      leading: Chip(
        backgroundColor: Color.fromARGB(255, 166, 235, 168),
        label: Text(bill.category!),
      ),
      title: Text(bill.title!),
      subtitle: Text("Kes. ${bill.amount}"),
      trailing: Text("${date.day}/${date.month}/${date.year}"),
    ));
  }

  return widgets;
}
