import 'package:crypto_wallet/constant.dart';
import 'package:crypto_wallet/injection.dart';
import 'package:crypto_wallet/presentation/bloc/mnemonic/mnemonic_cubit.dart';
import 'package:crypto_wallet/presentation/global_widgets/reusable_button.dart';
import 'package:crypto_wallet/presentation/verify_phrase/verify_phrase.dart';
import 'package:crypto_wallet/repository/wallet_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MnemonicPage extends StatefulWidget {
  static String id = "MnemonicPage";
  const MnemonicPage({Key? key}) : super(key: key);

  @override
  State<MnemonicPage> createState() => _MnemonicPageState();
}

class _MnemonicPageState extends State<MnemonicPage> {
  late MnemonicCubit _mnemonicCubit;

  @override
  void initState() {
    super.initState();

    _mnemonicCubit = MnemonicCubit(getIt<IWalletRepository>());
    _mnemonicCubit.generateMnemonics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MnemonicCubit, MnemonicState>(
          bloc: _mnemonicCubit,
          builder: (context, state) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kkHorizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  headerText(context),
                  const SizedBox(height: 20),
                  Wrap(
                      alignment: WrapAlignment.center,
                      children: List.generate(
                          state.mnemonics!.length,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "${index + 1} | ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.copyWith(color: Colors.grey),
                                        ),
                                        Text(
                                          state.mnemonics![index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                              )).toList()),
                  const SizedBox(height: 25),
                  _copyButton(state.mnemonics, context),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 19),
                    decoration: BoxDecoration(
                        color: Colors.redAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Do not share your secret phrases!',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red.shade900),
                        ),
                        const SizedBox(height: 10),
                        Text(
                            'If someone has the secret phrase they will have full control of your wallet',
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.subtitle1?.copyWith(
                                      color: Colors.red.shade900,
                                    )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ReusableButton(
                    label: 'CONTINUE',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: _mnemonicCubit,
                            child: const VerifyPhrasePage(),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

_copyButton(List<String>? mnemonics, BuildContext context) {
  return ElevatedButton(
    onPressed: () async {
      final _joinedString = mnemonics!.join(' ');
      await Clipboard.setData(ClipboardData(text: _joinedString)).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Copied to your clipboard !')));
      });

      print('copied data :$_joinedString');
    },
    child: const Text('COPY'),
  );
}

Column headerText(BuildContext context) {
  return Column(
    children: [
      const SizedBox(height: 30),
      Text('Your recovery phrase',
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
            'Write down or copy these words in the right order and save them somewhere safe.',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: Colors.grey[800])),
      ),
    ],
  );
}
