import 'package:crypto_wallet/api/configuration.dart';
import 'package:crypto_wallet/api/wallet_address.dart';
import 'package:crypto_wallet/injection.dart';
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
        home: WelcomePage());
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late Configuration config;

  late IWalletAddress walletAddress;

  @override
  void initState() {
    super.initState();

    config = Configuration(sharedPreferences: getIt<SharedPreferences>());

    walletAddress = WalletAddress(config);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14.0),
              child: Text('Import Wallet'),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final _mnemonic = walletAddress.generateMnemonic();
              // ignore: avoid_print
              print("mnemonic: $_mnemonic");
              final result = await walletAddress.setupFromMnemonic(_mnemonic);
              // ignore: avoid_print

              print(result);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14.0),
              child: Text('Generate Wallet'),
            ),
          ),
        ],
      ),
    );
  }
}
