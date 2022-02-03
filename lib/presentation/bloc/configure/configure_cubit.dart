import 'package:bloc/bloc.dart';
import 'package:crypto_wallet/presentation/bloc/import_field/import_field_cubit.dart';
import 'package:equatable/equatable.dart';

import 'package:crypto_wallet/repository/wallet_repository.dart';

part 'configure_state.dart';

class ConfigureCubit extends Cubit<ConfigureState> {
  ConfigureCubit({
    required this.walletRepository,
    required this.importFieldCubit,
  }) : super(ConfigureInitial());
  final IWalletRepository walletRepository;
  final ImportFieldCubit importFieldCubit;

  void setMnemonice(List<String> mnemonic) async {
    final joinedPhrases = mnemonic.join(" ");
    emit(ConfigureLoading());
    await walletRepository.setupFromMnemonic(joinedPhrases);

    emit(ConfigureSuccess());
  }

  void setupMnemonicImport() async {
    try {
      emit(ConfigureLoading());

      await walletRepository.setupFromMnemonic(_mnemonic);

      emit(ConfigureSuccess());
    } catch (e) {
      print('exception :$e');
      print('error occured while importing wallet');
      emit(ConfigureStateFailure());
    }
  }
}

const _mnemonic =
    """green glimpse soap powder reflect congress hockey lunar jump ransom wamp glow""";
