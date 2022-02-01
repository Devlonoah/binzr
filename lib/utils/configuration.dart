//Configuration will be in charge of
// * Persisting [saving] & Fetching some basic data/information

import 'package:shared_preferences/shared_preferences.dart';

import '../api/app_key.dart';

abstract class IConfiguration {
  ///* [write] mnemonic value
  Future<bool> setMnemonic(String value);

  ///* aset app passcode [access code]

  Future<bool> setPasscode(String passcode);

  ///* Finish setting up wallet
  Future<bool?> setUpDone(bool value);

  ///* Write private key
  Future<bool> setPrivateKey(String value);

  ///* Check if wallet has been created [setup]
  Future<bool?> didSetupWallet();

  //wallet address

  ///* Fetch wallet address , return null if empty
  Future<String?> getMnemonic();

  ///* Fetch private key

  Future<String?> getPrivateKey();

  ///* Fetch passcode
  Future<String?> getPasscode();
}

class Configuration implements IConfiguration {
  Configuration({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;
  final SharedPreferences _sharedPreferences;

  @override
  Future<bool?> didSetupWallet() async =>
      _sharedPreferences.getBool(AppKey.didSetUPWallet);

  @override
  Future<String?> getMnemonic() async =>
      _sharedPreferences.getString(AppKey.mnemonic);

  @override
  Future<String?> getPrivateKey() async =>
      _sharedPreferences.getString(AppKey.privateKey);

  @override
  Future<bool> setMnemonic(String? value) async =>
      await _sharedPreferences.setString(AppKey.mnemonic, value!);

  @override
  Future<bool> setPrivateKey(String value) async {
    return await _sharedPreferences.setString(AppKey.privateKey, value);
  }

  @override
  Future<bool?> setUpDone(bool value) async =>
      _sharedPreferences.setBool(AppKey.didSetUPWallet, value);

  @override
  Future<bool> setPasscode(String passcode) async {
    return _sharedPreferences.setString(AppKey.passcode, passcode);
  }

  @override
  Future<String?> getPasscode() async {
    return _sharedPreferences.getString(AppKey.passcode);
  }
}
