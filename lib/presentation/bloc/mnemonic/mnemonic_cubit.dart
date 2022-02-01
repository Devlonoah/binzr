import 'package:bloc/bloc.dart';
import 'package:crypto_wallet/repository/wallet_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:crypto_wallet/utils/wallet_address.dart';

part 'mnemonic_state.dart';

class MnemonicCubit extends Cubit<MnemonicState> {
  final IWalletRepository walletRepository;
  MnemonicCubit(
    this.walletRepository,
  ) : super(MnemonicState.initialState());

  void generateMnemonics() async {
    print('generating mnemonics');

    final mnemonics = await walletRepository.generateMnemonics();
    print("mnemonics  =>>> :$mnemonics");

    final splittedMnemonics = mnemonics.split(" ");

    print('splitted mnemonics $splittedMnemonics');
    final updatedState = state.copyWith(mnemonics: splittedMnemonics);

    emit(updatedState);
  }

  void checkBoxChange(bool? value) {
    emit(state.copyWith(isCopied: value));
  }
}
