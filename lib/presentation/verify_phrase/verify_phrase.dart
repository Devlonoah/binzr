import 'package:crypto_wallet/constant.dart';
import 'package:crypto_wallet/injection.dart';
import 'package:crypto_wallet/presentation/bloc/configure/configure_cubit.dart';
import 'package:crypto_wallet/presentation/bloc/mnemonic/mnemonic_cubit.dart';
import 'package:crypto_wallet/presentation/bloc/verify_phrase/verify_phrase_cubit.dart';
import 'package:crypto_wallet/presentation/global_widgets/custom_loading_widget.dart';
import 'package:crypto_wallet/presentation/global_widgets/reusable_button.dart';
import 'package:crypto_wallet/presentation/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

class VerifyPhrasePage extends StatefulWidget {
  const VerifyPhrasePage({Key? key}) : super(key: key);

  @override
  State<VerifyPhrasePage> createState() => _VerifyPhrasePageState();
}

class _VerifyPhrasePageState extends State<VerifyPhrasePage> {
  late VerifyPhraseCubit verifyPhraseCubit;

  late ConfigureCubit configureCubit;
  @override
  void initState() {
    super.initState();

    var _passedPhrase = BlocProvider.of<MnemonicCubit>(context).state.mnemonics;
    verifyPhraseCubit = VerifyPhraseCubit(_passedPhrase!);

    configureCubit = getIt<ConfigureCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ConfigureCubit, ConfigureState>(
        bloc: configureCubit,
        listener: (context, state) {
          if (state is ConfigureSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, HomePage.id, (route) => false);
          }
        },
        child: MultiBlocProvider(providers: [
          BlocProvider.value(value: configureCubit),
          BlocProvider.value(value: verifyPhraseCubit),
        ], child: verifyPageBody()),
      ),
    );
  }

  verifyPageBody() {
    return BlocBuilder<VerifyPhraseCubit, VerifyPhraseState>(
        builder: (context, state) {
      return SafeArea(
        child: LoadingOverlay(
          isLoading: context.watch<ConfigureCubit>().state is ConfigureLoading,
          color: Colors.grey[500],
          progressIndicator: const CustomLoadingWidget(),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kkHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                headerText(context),
                selectedPhrases(context),
                const SizedBox(height: 20),
                shuffledPassPhrase(context),
                const Spacer(),
                ReusableButton(
                  label: 'CONTINUE',
                  onPressed: state.isMatched!
                      ? () {
                          BlocProvider.of<ConfigureCubit>(context)
                              .setMnemonice(state.selectedPhrase!);
                        }
                      : null,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget shuffledPassPhrase(BuildContext context) {
    return BlocBuilder<VerifyPhraseCubit, VerifyPhraseState>(
      builder: (context, state) {
        return Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            children: List.generate(
                state.shuffledPhrase!.length,
                (index) => GestureDetector(
                      onTap: () {
                        context
                            .read<VerifyPhraseCubit>()
                            .phraseSelected(state.shuffledPhrase![index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                  state.shuffledPhrase![index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                      ),
                    )).toList());
      },
    );
  }

  selectedPhrases(BuildContext context) {
    return BlocBuilder<VerifyPhraseCubit, VerifyPhraseState>(
      builder: (context, state) {
        if (state.selectedPhrase!.isEmpty) {
          return Container(
            height: 100,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Tap to verify recovery phrase ',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          );
        }
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              children: List.generate(
                  state.selectedPhrase!.length,
                  (index) => GestureDetector(
                        onTap: () {
                          // context
                          //     .read<VerifyPhraseCubit>()
                          //     .phraseSelected(state.shuffledPhrase![index]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                    state.selectedPhrase![index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ),
                      )).toList()),
        );
      },
    );
  }
}

Column headerText(BuildContext context) {
  return Column(
    children: [
      const SizedBox(height: 30),
      Text('Verify recovery phrase',
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
            'Tap the words to put them next to each oter in the correct order.',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: Colors.grey[800])),
      ),
      const SizedBox(height: 10),
    ],
  );
}
