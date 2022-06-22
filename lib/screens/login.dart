import 'package:billed/screens/pin_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controller = TextEditingController();

  void loginUser() {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.verifyPhoneNumber(
        phoneNumber: "+254${_controller.text}",
        verificationCompleted: (_) => {},
        verificationFailed: (_) =>
            const ScaffoldMessenger(child: Text("Verification failed")),
        codeSent: (String verificationId, _) => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          PinCode(auth: auth, verificationId: verificationId)))
            },
        codeAutoRetrievalTimeout: (_) => {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your phone number',
                style: Theme.of(context).textTheme.headline2),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
                width: 300,
                child: Text(
                  "Pick your country code and enter your phone number",
                  textAlign: TextAlign.center,
                )),
            const SizedBox(
              height: 30,
            ),
            TextField(
              keyboardType: TextInputType.none,
              decoration: InputDecoration(
                enabled: false,
                labelText: "🇰🇪 Kenya",
                labelStyle: const TextStyle(color: Colors.grey),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                suffixIcon: Icon(
                  Icons.keyboard_arrow_right,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                  enabled: true,
                  labelText: "Phone number",
                  labelStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).iconTheme.color!),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  prefix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        '+254',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      VerticalDivider(
                        width: 1,
                        color: Colors.grey,
                      )
                    ],
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
                onPressed: () => showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => SizedBox(
                          height: 200,
                          child: AlertDialog(
                            backgroundColor: Theme.of(context).canvasColor,
                            title: const Center(child: Text('Phone number')),
                            titlePadding: const EdgeInsets.all(10),
                            contentPadding:
                                const EdgeInsets.only(left: 10, right: 10),
                            alignment: Alignment.center,
                            content: Text(
                              'Is this your number? +254 ${_controller.text}',
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Edit")),
                              TextButton(
                                  onPressed: () => loginUser(),
                                  child: const Text("Yes"))
                            ],
                            actionsAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        )),
                child: Text(
                  "Next",
                  style: Theme.of(context).textTheme.headline3,
                ))
          ],
        ),
      ),
    );
  }
}
