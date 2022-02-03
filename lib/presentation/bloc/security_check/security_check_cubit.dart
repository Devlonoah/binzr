import 'package:bloc/bloc.dart';
import 'package:crypto_wallet/utils/wallet_address.dart';
import 'package:equatable/equatable.dart';

part 'security_check_state.dart';

class SecurityCheckCubit extends Cubit<SecurityCheckState> {
  SecurityCheckCubit({required this.walletAddress})
      : super(SecurityCheckState.initialState());

  final IWalletAddress walletAddress;

  void verifyPassword(List<String> value) async {
    emit(state.copyWith(
      isChecking: true,
      isSuccess: false,
      isFailed: false,
    ));

    var joinedValue = value.join();
    String? result = await walletAddress.getPasscode();

    if (joinedValue == result) {
      emit(state.copyWith(
        isSuccess: true,
        isFailed: false,
        isChecking: false,
      ));
    } else {
      emit(state.copyWith(
        isSuccess: false,
        isFailed: true,
        isChecking: false,
      ));
    }

    // if (result == null) {
    //   if (joinedValue.length == 5) {
    //     //* set passcode//write//save
    //     bool result = await walletAddress.setPasscode(joinedValue);

    //     emit(state.copyWith(
    //         header: 'Set new Passcode',
    //         isSuccess: true,
    //         isFailed: false,
    //         isChecking: false));
    //   } else {
    //     return emit(state.copyWith(
    //       header: 'Set new Passcode',
    //       isFailed: true,
    //       isSuccess: false,
    //       isChecking: false,
    //     ));
    //   }
    // } else if (result != null) {
    //   emit(state.copyWith(
    //     isSuccess: true,
    //     isFailed: false,
    //     isChecking: false,
    //   ));
    // }
  }

  setupPasscode(List<String> passcode) async {
    try {
      emit(state.copyWith(isChecking: true));

      var joinedValue = passcode.join();
      var result = await walletAddress.setPasscode(joinedValue);

      emit(state.copyWith(isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isFailed: true));
    }
  }
}
