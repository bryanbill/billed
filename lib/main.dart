import 'package:billed/utils/app_router.dart';
import 'package:billed/utils/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Billed",
      routes: AppRouter.routes,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.light,
    );
  }
}
