import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Dashboard'),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: Icon(Icons.person),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            const Text("Hello, John"),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Row(
                children: [
                  Column(
                    children: const [
                      Text("Average Bill"),
                      Text("Kes. 200,000")
                    ],
                  ),
                  const Text("Kes. 234,000")
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Actions"),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width / 3 - 50,
                  alignment: Alignment.center,
                  child: const Icon(Icons.add),
                ),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width / 3 - 50,
                  alignment: Alignment.center,
                  child: const Icon(Icons.share),
                ),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width / 3 - 50,
                  alignment: Alignment.center,
                  child: const Icon(Icons.payment),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Recents"),
            const SizedBox(
              height: 10,
            ),
            const ListTile(
              subtitle: Chip(
                backgroundColor: Color.fromARGB(255, 166, 235, 168),
                label: Text("Food"),
              ),
              title: Text("Food stuff"),
              trailing: Text("Kes. 12,000"),
            )
          ],
        ),
      ),
    );
  }
}
