import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.I;

Future<void> initInjection() async {
  final _sharedPreferenceInstance = await SharedPreferences.getInstance();

  getIt.registerLazySingleton(() => _sharedPreferenceInstance);
}
