import 'package:flutter/material.dart';

class FriendsList extends StatefulWidget {
  const FriendsList({Key? key}) : super(key: key);

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Friends'),
        ),
        body: Container(
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
                      children: const [
                        CircleAvatar(
                          child: Text("20"),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Connections",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text("John Doe"),
                  subtitle: Text("4 bills"),
                  trailing: Icon(Icons.more_vert),
                )
              ],
            )));
  }
}
