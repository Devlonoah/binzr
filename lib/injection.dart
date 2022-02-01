import 'package:crypto_wallet/presentation/bloc/configure/configure_cubit.dart';
import 'package:crypto_wallet/presentation/bloc/mnemonic/mnemonic_cubit.dart';
import 'package:crypto_wallet/presentation/bloc/security_check/security_check_cubit.dart';
import 'package:crypto_wallet/repository/wallet_repository.dart';
import 'package:crypto_wallet/utils/configuration.dart';
import 'package:crypto_wallet/utils/wallet_address.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.I;

Future<void> initInjection() async {
  final _sharedPreferenceInstance = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<SharedPreferences>(
      () => _sharedPreferenceInstance);

  getIt.registerLazySingleton(
      () => Configuration(sharedPreferences: _sharedPreferenceInstance));
  getIt.registerLazySingleton<IWalletAddress>(() => WalletAddress(getIt()));

  getIt.registerLazySingleton<IWalletRepository>(
      () => WalletRepository(walletAddress: getIt()));

  getIt.registerFactory(() => SecurityCheckCubit(walletAddress: getIt()));

  getIt.registerFactory(() => MnemonicCubit(getIt()));

  getIt.registerFactory(() => ConfigureCubit(getIt()));
}
