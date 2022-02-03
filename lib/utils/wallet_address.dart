import 'package:bip39/bip39.dart' as bip39;
import 'configuration.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:hex/hex.dart';
import 'package:web3dart/web3dart.dart';

abstract class IWalletAddress {
  String generateMnemonic();

  Future<String> getPrivateKey(String mnemonic);

  Future<EthereumAddress> getPublicAddress(String privateKey);

  Future<bool> setupFromMnemonic(String mnemonic);

  Future<bool> setupFromPrivateKey(String privateKey);
  String entropyToMnemonic(String entropyMnemonic);

  Future<bool> setPasscode(String value);

  Future<String?> getPasscode();

  Future<bool?> isSetUpDone();
}

class WalletAddress implements IWalletAddress {
  final Configuration _configuration;

  WalletAddress(this._configuration);
  @override
  String entropyToMnemonic(String entropyToMnemonic) {
    return bip39.entropyToMnemonic(entropyToMnemonic);
  }

  @override
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  @override
  Future<String> getPrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeedHex(mnemonic);

    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(HEX.decode(seed));

    final privateKey = HEX.encode(master.key);

    return privateKey;
  }

  @override
  Future<EthereumAddress> getPublicAddress(String privateKey) async {
    final private = EthPrivateKey.fromHex(privateKey);

    final address = await private.extractAddress();

    return address;
  }

  @override
  Future<bool> setupFromMnemonic(String mnemonic) async {
    final cryptMnemonic = bip39.mnemonicToEntropy(mnemonic);
    final privateKey = await getPrivateKey(mnemonic);

    await _configuration.setMnemonic(cryptMnemonic);
    await _configuration.setPrivateKey(privateKey);

    await _configuration.setUpDone(true);

    return true;
  }

  @override
  Future<bool> setupFromPrivateKey(String privateKey) async {
    await _configuration.setMnemonic(null);
    await _configuration.setPrivateKey(privateKey);
    await _configuration.setUpDone(true);
    return true;
  }

  Future<bool> setPasscode(String passcode) async {
    return await _configuration.setPasscode(passcode);
  }

  @override
  Future<String?> getPasscode() async {
    return await _configuration.getPasscode();
  }

  @override
  Future<bool?> isSetUpDone() async {
    return await _configuration.didSetupWallet();
  }
}
