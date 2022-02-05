import 'package:crypto_wallet/presentation/app_start/app_start.dart';
import 'package:crypto_wallet/presentation/backup_message/backup_message.dart';
import 'package:crypto_wallet/presentation/home/bloc/home_cubit.dart';
import 'package:crypto_wallet/presentation/home/home.dart';
import 'package:crypto_wallet/presentation/import/import_page.dart';
import 'package:crypto_wallet/presentation/mnemonic/mnemonic_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'presentation/launch/launch_page.dart';
import 'presentation/pass_code/pass_code_page.dart';

import 'injection.dart';
import 'package:flutter/material.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<HomeCubit>()),
      ],
      child: MaterialApp(
        title: 'Crypto wallet',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.ubuntu().fontFamily,
        ),
        routes: {
          LaunchPage.id: (context) => const LaunchPage(),
          PassCodePage.id: (context) => const PassCodePage(),
          BackupMessagePage.id: (context) => const BackupMessagePage(),
          MnemonicPage.id: (context) => const MnemonicPage(),
          HomePage.id: (context) => const HomePage(),
          ImportWalletPage.id: (context) => const ImportWalletPage(),
          AppStart.id: (context) => const AppStart()
        },
        initialRoute: PassCodePage.id,
      ),
    );
  }
}
