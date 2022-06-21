import 'package:billed/utils/app_router.dart';
import 'package:flutter/material.dart';

class PinCode extends StatefulWidget {
  const PinCode({Key? key}) : super(key: key);

  @override
  State<PinCode> createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode> {
  final TextEditingController _pinController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _pinController.addListener(() {
      _pinController.text.length == 6
          ? Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRouter.dashboard, (_) => false)
          : null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pinController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("Enter Received Pin Code",
                style: Theme.of(context).textTheme.headline2),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: _pinController,
              autofocus: true,
              maxLength: 6,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                  helperText: "Enter 6 digit pin code",
                  helperStyle: Theme.of(context).textTheme.bodyText2,
                  hintStyle: Theme.of(context).textTheme.bodyText2,
                  hintText: "_ _ _ _ _ _",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).iconTheme.color!))),
            ),
          ]),
        ));
  }
}
