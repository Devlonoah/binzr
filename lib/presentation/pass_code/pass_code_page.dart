import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

import '../../constant.dart';
import '../bloc/passcode/passcode_checking_cubit.dart';
import '../bloc/passcode/passcode_cubit.dart';
import '../bloc/passcode/passcode_form_cubit.dart';

class PassCodePage extends StatefulWidget {
  static String id = "PassCodePage";
  const PassCodePage({Key? key}) : super(key: key);

  @override
  State<PassCodePage> createState() => _PassCodePageState();
}

class _PassCodePageState extends State<PassCodePage> {
  late TextEditingController controller;

  PasscodeCubit? passcodeCubit;

  PasscodeFormCubit? passcodeFormCubit;

  late PasscodeCheckingCubit passcodeCheckingCubit;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();

    passcodeCubit = PasscodeCubit();
    passcodeFormCubit = PasscodeFormCubit(passcodeCubit!);
    passcodeCheckingCubit = PasscodeCheckingCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PasscodeCheckingCubit, PasscodeCheckingState>(
      listener: (context, state) {
        if (state is PasscodeMatched) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('passcode matched')));
        }
      },
      bloc: passcodeCheckingCubit,
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: LoadingOverlay(
              isLoading: state is PasscodeCheckingProgress,
              color: Colors.grey[500],
              progressIndicator: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5)),
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
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
          print('current state at UI is : ${state.data}');
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
          rightButtonFn: () => passcodeCheckingCubit.verifyPasscode(state.data),
        );
      },
    );
  }
}
