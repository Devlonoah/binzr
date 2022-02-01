import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:crypto_wallet/repository/wallet_repository.dart';

part 'configure_state.dart';

class ConfigureCubit extends Cubit<ConfigureState> {
  ConfigureCubit(
    this.walletRepository,
  ) : super(ConfigureInitial());
  final IWalletRepository walletRepository;

  void setMnemonice(List<String> mnemonic) async {
    final joinedPhrases = mnemonic.join(" ");
    emit(ConfigureLoading());
    await walletRepository.setupFromMnemonic(joinedPhrases);

    emit(ConfigureSuccess());
  }
}
