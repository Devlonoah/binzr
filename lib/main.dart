import 'presentation/launch/launch_page.dart';
import 'presentation/pass_code/pass_code_page.dart';

import 'utils/configuration.dart';
import 'utils/wallet_address.dart';
import 'injection.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initInjection();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto wallet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        LaunchPage.id: (context) => const LaunchPage(),
        PassCodePage.id: (context) => const PassCodePage(),
      },
      initialRoute: LaunchPage.id,
    );
  }
}
