import 'package:billed/screens/widgets/friends_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FriendsList extends StatefulWidget {
  const FriendsList({Key? key}) : super(key: key);

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  final Stream<QuerySnapshot> _friendsStream = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("friends")
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Friends'),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: null,
            builder: (context, snapshot) {
              List<Map<String, dynamic>> friends = [];
              if (snapshot.hasData) {
                for (var element in snapshot.data!.docs) {
                  friends.add(element.data() as Map<String, dynamic>);
                }
              }
              return Container(
                  padding: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    children: [
                      Container(
                        height: 100,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(2, 2),
                                  color: Theme.of(context).primaryColor)
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColorLight),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                child: Text(friends.length.toString()),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Connections",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ...friendsList(friends)
                    ],
                  ));
            }));
  }
}
