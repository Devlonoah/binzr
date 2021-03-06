import 'package:crypto_wallet/utils/wallet_address.dart';

abstract class IWalletRepository {
  Future<String> generateMnemonics();
  Future<bool> setupFromMnemonic(String mnemonic);

  Future<bool> setupFromPrivateKey(String privateKey);

  Future<bool?> isSetUpDone();
}

class WalletRepository implements IWalletRepository {
  WalletRepository({
    required IWalletAddress walletAddress,
  }) : _walletAddress = walletAddress;

  IWalletAddress _walletAddress;

  @override
  Future<String> generateMnemonics() async {
    return _walletAddress.generateMnemonic();
  }

  @override
  Future<bool> setupFromMnemonic(String mnemonic) {
    return _walletAddress.setupFromMnemonic(mnemonic);
  }

  @override
  Future<bool> setupFromPrivateKey(String privateKey) {
    return _walletAddress.setupFromPrivateKey(privateKey);
  }

  @override
  Future<bool?> isSetUpDone() async {
    return await _walletAddress.isSetUpDone();
  }

  Future getWalletAddress() async {
    return await _walletAddress.getWalletAddress();
  }
}
