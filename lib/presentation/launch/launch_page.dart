import '../../constant.dart';
import '../pass_code/pass_code_page.dart';
import 'package:flutter/material.dart';

class LaunchPage extends StatelessWidget {
  static String id = "LaunchPage";
  const LaunchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: LaunchPageBody());
  }
}

class LaunchPageBody extends StatelessWidget {
  const LaunchPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kkHorizontalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 55),
          Expanded(
            child: Image.asset(
              'asset/background/3d-flame-277.png',
            ),
          ),
          ElevatedButton(
            style: TextButton.styleFrom(backgroundColor: Colors.black),
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Text('CREATE WALLET'),
            ),
          ),
          const SizedBox(height: 25),
          Center(
            child: GestureDetector(
              onTap: () => navigateToPasscode(context),
              child: const Text(
                'I already have a wallet',
                style: TextStyle(fontSize: 12, color: Color(0xFFFF5E00)),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  navigateToPasscode(BuildContext context) {
    Navigator.pushNamed(context, PassCodePage.id);
  }
}
