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
            const Text(
              "Hello, John",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(5, 10),
                        color: Theme.of(context).primaryColorLight),
                  ],
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        "Average Bill",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        "Kes. 200,000",
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      )
                    ],
                  ),
                  const Spacer(),
                  const Text(
                    "Kes. 234,000\nPending",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
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
