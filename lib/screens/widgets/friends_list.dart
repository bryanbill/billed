import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

List<Widget> friendsList(List<Map<String, dynamic>> friends) {
  List<Widget> widgets = [];

  for (var friend in friends) {
    widgets.add(ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(
          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png",
          fit: BoxFit.cover,
        ),
      ),
      title: Text(friend['user'].toString().substring(3, 7)),
      subtitle: Text(
          "Connected on${(friend['createdAt'] as Timestamp).toDate().day}th, ${(friend['createdAt'] as Timestamp).toDate().month}/${(friend['createdAt'] as Timestamp).toDate().year}"),
      trailing: const Icon(Icons.more_vert),
    ));
  }
  return widgets;
}
