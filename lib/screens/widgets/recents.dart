import 'package:billed/models/bill_model.dart';

import 'package:flutter/material.dart';

List<Widget> recents(List<BillModel> bills) {
  List<Widget> widgets = [];

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
