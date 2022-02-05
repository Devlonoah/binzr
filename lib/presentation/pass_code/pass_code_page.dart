import 'package:crypto_wallet/api/blockchain_remote_data_source.dart';
import 'package:crypto_wallet/function/show_snack_bar.dart';
import 'package:crypto_wallet/presentation/app_start/app_start.dart';
import 'package:crypto_wallet/presentation/bloc/security_check/security_check_cubit.dart';
import 'package:crypto_wallet/presentation/bloc/security_status_check/security_status_check_cubit.dart';
import 'package:crypto_wallet/presentation/global_widgets/custom_loading_widget.dart';
import 'package:crypto_wallet/utils/configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

import '../../constant.dart';
import '../../injection.dart';
import '../bloc/passcode/passcode_checking_cubit.dart';
import '../bloc/passcode/passcode_cubit.dart';
import '../bloc/passcode/passcode_form_cubit.dart';

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

  late SecurityStatusCheckCubit securityStatusCheckCubit;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();

    passcodeCubit = PasscodeCubit();
    passcodeFormCubit = PasscodeFormCubit(passcodeCubit!);
    passcodeCheckingCubit = PasscodeCheckingCubit();

    securityCheckCubit = getIt<SecurityCheckCubit>();

    securityStatusCheckCubit = getIt<SecurityStatusCheckCubit>()
      ..checkSecurityStatus();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: securityStatusCheckCubit),
        BlocProvider.value(value: securityCheckCubit),
        BlocProvider.value(value: passcodeCubit!)
      ],
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<SecurityCheckCubit, SecurityCheckState>(
            listener: (context, state) {
              if (state.isSuccess!) {
                _navigateToAppStart(context);
              }

              if (state.isFailed!) {
                showSnackBar(context: context, message: 'Invalid passcode');
              }
            },
            child:
                BlocBuilder<SecurityStatusCheckCubit, SecurityStatusCheckState>(
                    builder: (context, state) {
              if (state is NotSecuredState) {
                return notSecured(context);
              }

              if (state is SecuredState) {
                return secured(context);
              }

              return const Center(
                child: CustomLoadingWidget(),
              );
            }),
          ),
        ),
      ),
    );
  }
}

secured(BuildContext context) {
  return LoadingOverlay(
    isLoading: false,
    color: Colors.grey[500],
    progressIndicator: const CustomLoadingWidget(),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: kkHorizontalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            height: 20,
          ),
          _headerText('Enter passcode'),
          _inputDisplay(),
          const SizedBox(height: 20),
          _numberInput(rightButtonFn: () {
            context
                .read<SecurityCheckCubit>()
                .verifyPassword(context.read<PasscodeCubit>().state.data);
          }),
          _subtitle()
        ],
      ),
    ),
  );
  // ),
}

notSecured(BuildContext context) {
  return LoadingOverlay(
      isLoading: false,
      color: Colors.grey[500],
      progressIndicator: const CustomLoadingWidget(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kkHorizontalPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 20),
            _headerText('Setup passcode'),
            _inputDisplay(),
            const SizedBox(height: 20),
            _numberInput(rightButtonFn: () {
              context
                  .read<SecurityCheckCubit>()
                  .setupPasscode(context.read<PasscodeCubit>().state.data);
            }),
            _subtitle()
          ],
        ),
      ));
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

_headerText(String header) {
  return BlocBuilder<SecurityStatusCheckCubit, SecurityStatusCheckState>(
      builder: (context, state) {
    return Text(
      header,
      style: Theme.of(context)
          .textTheme
          .headline6
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  });
}

Expanded _inputDisplay() {
  return Expanded(
    child: BlocBuilder<PasscodeCubit, ValidationState>(
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

_numberInput({dynamic Function()? rightButtonFn}) {
  return BlocBuilder<PasscodeCubit, ValidationState>(
    builder: (context, state) {
      return NumericKeyboard(
        onKeyboardTap: (x) => context.read<PasscodeCubit>().updateValue(x),
        leftIcon: const Icon(Icons.arrow_back),
        rightIcon: const Icon(Icons.check, color: Colors.green),
        leftButtonFn: () => context.read<PasscodeCubit>().clearValue(),
        rightButtonFn: rightButtonFn,
      );
    },
  );
}

_navigateToAppStart(BuildContext context) {
  return Navigator.pushNamedAndRemoveUntil(
      context, AppStart.id, (route) => false);
}
