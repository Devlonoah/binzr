import 'package:crypto_wallet/api/blockchain_remote_data_source.dart';
import 'package:crypto_wallet/presentation/bloc/configure/configure_cubit.dart';
import 'package:crypto_wallet/presentation/bloc/import_field/import_field_cubit.dart';
import 'package:crypto_wallet/presentation/bloc/mnemonic/mnemonic_cubit.dart';
import 'package:crypto_wallet/presentation/bloc/security_check/security_check_cubit.dart';
import 'package:crypto_wallet/presentation/bloc/security_status_check/security_status_check_cubit.dart';
import 'package:crypto_wallet/presentation/bloc/user_exist/user_exist_cubit.dart';
import 'package:crypto_wallet/presentation/home/bloc/home_cubit.dart';
import 'package:crypto_wallet/repository/remote_wallet_access.dart';
import 'package:crypto_wallet/repository/wallet_repository.dart';
import 'package:crypto_wallet/utils/configuration.dart';
import 'package:crypto_wallet/utils/wallet_address.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

GetIt getIt = GetIt.I;

Future<void> initInjection() async {
  final _sharedPreferenceInstance = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<SharedPreferences>(
      () => _sharedPreferenceInstance);

  getIt.registerLazySingleton<http.Client>(() => http.Client());

  getIt.registerLazySingleton(
      () => Configuration(sharedPreferences: _sharedPreferenceInstance));
  getIt.registerLazySingleton<IWalletAddress>(() => WalletAddress(getIt()));

  getIt.registerLazySingleton<IWalletRepository>(
      () => WalletRepository(walletAddress: getIt()));

  getIt.registerLazySingleton(() => RemoteWalletAccess(
      blockChainRemoteDataSource: getIt(), walletAddress: getIt()));

  getIt.registerLazySingleton(
      () => BlockChainRemoteDataSource(getIt(), getIt()));

  getIt.registerFactory(() => SecurityCheckCubit(walletAddress: getIt()));

  getIt.registerFactory(() => MnemonicCubit(getIt()));

  getIt.registerFactory(() => ImportFieldCubit());

  getIt.registerFactory(() =>
      ConfigureCubit(walletRepository: getIt(), importFieldCubit: getIt()));

  getIt.registerFactory(() => SecurityStatusCheckCubit(getIt()));

  getIt.registerFactory(() => UserExistCubit(getIt()));

  getIt.registerFactory(() => HomeCubit(getIt()));
}
