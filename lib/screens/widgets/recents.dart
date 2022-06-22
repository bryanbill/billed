import 'package:billed/models/bill_model.dart';

import 'package:flutter/material.dart';

List<Widget> recents(List<BillModel> bills) {
  List<Widget> widgets = [];

  for (BillModel bill in bills) {
    var date = bill.date!.toDate();
    widgets.add(ListTile(
      title: Text(bill.title!),
      subtitle: Text("Kes. ${bill.amount}"),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("${date.day}/${date.month}/${date.year}"),
        ],
      ),
    ));
  }

  return widgets;
}
