import 'package:crypto_wallet/constant.dart';
import 'package:crypto_wallet/presentation/backup_message/cubit/agreement_cubit.dart';
import 'package:crypto_wallet/presentation/global_widgets/reusable_button.dart';
import 'package:crypto_wallet/presentation/mnemonic/mnemonic_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BackupMessagePage extends StatefulWidget {
  static String id = "BackupMessagePage";
  const BackupMessagePage({Key? key}) : super(key: key);

  @override
  State<BackupMessagePage> createState() => _BackupMessagePageState();
}

class _BackupMessagePageState extends State<BackupMessagePage> {
  late AgreementCubit agreementCubit;

  @override
  void initState() {
    super.initState();

    agreementCubit = AgreementCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kkHorizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              headerText(context),
              // centeredImage(),
              bottomTextAndButton(context, agreementCubit),
            ],
          ),
        ),
      ),
    );
  }

  Column headerText(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Text('Back up your wallet now!',
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
              'In the next step you will see 12 words that allows you to recover a wallet',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: Colors.grey[800])),
        ),
      ],
    );
  }

  centeredImage() {}

  bottomTextAndButton(BuildContext context, AgreementCubit agreementCubit) {
    return BlocBuilder<AgreementCubit, AgreementState>(
      bloc: agreementCubit,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Checkbox(
                    value: state.isAddedToService,
                    onChanged: (x) {
                      agreementCubit.updateCondition(x!);
                    }),
                Expanded(
                  child: Text(
                    'I understand that if i lose my recovery words,I will not be able to access my wallet.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(color: Colors.blue),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            ReusableButton(
              label: 'CONTINUE',
              onPressed: state.isAddedToService
                  ? () => _navigateToMnemonicPage(context)
                  : null,
            ),
            const SizedBox(height: 30)
          ],
        );
      },
    );
  }
}

void _navigateToMnemonicPage(BuildContext context) {
  Navigator.pushNamed(context, MnemonicPage.id);
}
