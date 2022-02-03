import 'package:bloc/bloc.dart';
import 'package:crypto_wallet/utils/wallet_address.dart';
import 'package:equatable/equatable.dart';

part 'security_status_check_state.dart';

class SecurityStatusCheckCubit extends Cubit<SecurityStatusCheckState> {
  SecurityStatusCheckCubit(this.walletAddress)
      : super(SecurityStatusCheckInitial());

  final IWalletAddress walletAddress;
  void checkSecurityStatus() async {
    final _passcode = await walletAddress.getPasscode();

    if (_passcode != null) {
      emit(SecuredState());
    } else {
      emit(NotSecuredState());
    }
  }
}
