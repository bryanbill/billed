import 'package:cloud_firestore/cloud_firestore.dart';

class BillModel {
  final String? id;
  final String? title;
  final String? category;
  final String? amount;
  final Timestamp? date;
  final String? user;

  BillModel({
    this.id,
    this.title,
    this.category,
    this.amount,
    this.date,
    this.user,
  });

  factory BillModel.fromJson(Map<String, dynamic> json) {
    return BillModel(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      amount: json['amount'],
      date: Timestamp.fromMillisecondsSinceEpoch(json['date']),
      user: json['user'],
    );
  }

  toMap() => {
        'id': id,
        'title': title,
        'category': category,
        'amount': amount,
        'date': Timestamp.now().millisecondsSinceEpoch,
        'user': user,
      };
}
