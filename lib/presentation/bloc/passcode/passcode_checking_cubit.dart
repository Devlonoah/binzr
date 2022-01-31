import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'passcode_checking_state.dart';

class PasscodeCheckingCubit extends Cubit<PasscodeCheckingState> {
  PasscodeCheckingCubit() : super(PasscodeCheckingInitial());

  // final WalletRepository walletRepository;

  void verifyPasscode(List<String> value) async {
    final String stringified = value.join();

    emit(PasscodeCheckingProgress());

    // final result = await walletRepository.getPasscode;

    await Future.delayed(const Duration(seconds: 2));

    // if (value == result) {
    emit(PasscodeMatched());
    // } else {
    //   PasscodeNotMatched();
    // }
  }
}
