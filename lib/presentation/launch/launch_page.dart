import 'package:crypto_wallet/presentation/backup_message/backup_message.dart';
import 'package:crypto_wallet/presentation/global_widgets/reusable_button.dart';

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
    return Stack(
      fit: StackFit.expand,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kkHorizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _text(context),
              const SizedBox(height: 60),
              ReusableButton(
                onPressed: () => _navigateToBackupMessage(context),
                label: 'CREATE WALLET',
              ),
              const SizedBox(height: 25),
              Center(
                child: GestureDetector(
                  onTap: () => navigateToPasscode(context),
                  child: const Text(
                    'I already have a wallet',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ],
    );
  }

  navigateToPasscode(BuildContext context) {
    Navigator.pushNamed(context, PassCodePage.id,
        arguments: JourneyType.import);
  }

  _text(BuildContext context) {
    return Column(
      children: [
        Text('Private and Secure',
            style: Theme.of(context).textTheme.headline5?.copyWith()),
        Text('Private keys never leave your device',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: Colors.grey)),
      ],
    );
  }
}

_navigateToBackupMessage(BuildContext context) =>
    Navigator.pushNamed(context, BackupMessagePage.id);
