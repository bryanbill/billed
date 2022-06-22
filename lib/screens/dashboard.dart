import 'package:billed/screens/all_bills.dart';
import 'package:billed/screens/friends_list.dart';
import 'package:billed/screens/widgets/add_bill_alert.dart';
import 'package:billed/screens/widgets/qr_widget.dart';
import 'package:billed/screens/widgets/scan_qr.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (context) => qrWidget(context, "data"),
              ),
              child: const CircleAvatar(
                child: Icon(Icons.person),
              ),
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
                        offset: const Offset(4, 4),
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FriendsList())),
                  child: Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width / 3 - 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 249, 249, 249)),
                    child: const Icon(Icons.people_alt),
                  ),
                ),
                GestureDetector(
                  onTap: () => showDialog(
                      context: context, builder: (_) => const AddBillAlert()),
                  child: Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width / 3 - 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(2, 2),
                              color: Theme.of(context).primaryColor)
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColorLight),
                    child: const Icon(
                      Icons.add,
                      size: 32,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AllBills())),
                  child: Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width / 3 - 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: const Icon(Icons.payments_outlined),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Recents"),
                TextButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const AllBills())),
                    child: const Text("See all"))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const ListTile(
              leading: Chip(
                backgroundColor: Color.fromARGB(255, 166, 235, 168),
                label: Text("Food"),
              ),
              title: Text("Food stuff"),
              subtitle: Text("Kes. 12,000"),
              trailing: Text("12th, Nov"),
            ),
            const ListTile(
              leading: Chip(
                backgroundColor: Color.fromARGB(255, 237, 204, 226),
                label: Text("Food"),
              ),
              title: Text("Food stuff"),
              subtitle: Text("Kes. 12,000"),
              trailing: Text("12th, Nov"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.person_add_alt),
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const QrScanner()))),
    );
  }
}
