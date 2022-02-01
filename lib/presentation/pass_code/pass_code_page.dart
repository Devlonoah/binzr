import 'package:crypto_wallet/presentation/bloc/security_check/security_check_cubit.dart';
import 'package:crypto_wallet/presentation/global_widgets/custom_loading_widget.dart';
import 'package:crypto_wallet/presentation/mnemonic/mnemonic_page.dart';
import 'package:crypto_wallet/utils/wallet_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

import '../../constant.dart';
import '../../injection.dart';
import '../bloc/passcode/passcode_checking_cubit.dart';
import '../bloc/passcode/passcode_cubit.dart';
import '../bloc/passcode/passcode_form_cubit.dart';

enum JourneyType { import, create }

class PassCodePage extends StatefulWidget {
  static String id = "PassCodePage";

  const PassCodePage({
    Key? key,
  }) : super(key: key);

  @override
  State<PassCodePage> createState() => _PassCodePageState();
}

class _PassCodePageState extends State<PassCodePage> {
  late TextEditingController controller;

  PasscodeCubit? passcodeCubit;

  PasscodeFormCubit? passcodeFormCubit;

  late PasscodeCheckingCubit passcodeCheckingCubit;

  late SecurityCheckCubit securityCheckCubit;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();

    passcodeCubit = PasscodeCubit();
    passcodeFormCubit = PasscodeFormCubit(passcodeCubit!);
    passcodeCheckingCubit = PasscodeCheckingCubit();

    securityCheckCubit = getIt<SecurityCheckCubit>();
  }

  @override
  Widget build(BuildContext context) {
    JourneyType _routeArgument =
        (ModalRoute.of(context)?.settings.arguments as JourneyType);

    return BlocConsumer<SecurityCheckCubit, SecurityCheckState>(
      listener: (context, state) {
        print("state is failed ?: ${state.isFailed}");
        print("state is success ? :${state.isSuccess}");
        if (state.isSuccess!) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Incorrect'),
            backgroundColor: Colors.red.shade900,
          ));
          print('congrat passcode typed match');
          if (_routeArgument == JourneyType.create) {
            //navigate to create wallet page
          } else if (_routeArgument == JourneyType.import) {
            //navigateTo  import wallet
          }
        }

        if (state.isFailed!) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Incorrect'),
            backgroundColor: Colors.red.shade900,
          ));
        }
      },
      bloc: securityCheckCubit,
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: LoadingOverlay(
              isLoading: state.isChecking,
              color: Colors.grey[500],
              progressIndicator: const CustomLoadingWidget(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kkHorizontalPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _inputDisplay(),
                    const SizedBox(height: 20),
                    _numberInput(),
                    _subtitle()
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Expanded _inputDisplay() {
    return Expanded(
      child: BlocBuilder<PasscodeCubit, ValidationState>(
        bloc: passcodeCubit,
        builder: (context, state) {
          // print('current state at UI is : ${state.data}');
          return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: (state.data as List<String>)
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor:
                              e == "x" ? Colors.black : Colors.blue.shade900,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 14,
                            child: Text(
                              e,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList());
        },
      ),
    );
  }

  Padding _subtitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        'Passcode adds an extra layer of security',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey[500]),
      ),
    );
  }

  BlocBuilder<PasscodeFormCubit, ValidationState<dynamic>> _numberInput() {
    return BlocBuilder<PasscodeFormCubit, ValidationState>(
      bloc: passcodeFormCubit,
      builder: (context, state) {
        return NumericKeyboard(
          onKeyboardTap: (x) => passcodeCubit?.updateValue(x),
          leftIcon: const Icon(Icons.arrow_back),
          rightIcon: const Icon(Icons.check, color: Colors.green),
          leftButtonFn: () => passcodeCubit?.clearValue(),
          rightButtonFn: () {
            Navigator.pushNamed(context, MnemonicPage.id);
            // securityCheckCubit.verifyPassword(state.data as List<String>);
          },
        );
      },
    );
  }
}
