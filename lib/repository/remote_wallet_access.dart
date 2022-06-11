import 'package:crypto_wallet/api/blockchain_remote_data_source.dart';
import 'package:crypto_wallet/models/balance_model.dart';
import 'package:crypto_wallet/utils/wallet_address.dart';

class RemoteWalletAccess {
  final BlockChainRemoteDataSource blockChainRemoteDataSource;
  final IWalletAddress walletAddress;

  RemoteWalletAccess({
    required this.blockChainRemoteDataSource,
    required this.walletAddress,
  });

  Future<BalanceModel> getBalance() async {
    final address = await walletAddress.getWalletAddress();
    print('waaleeet  $address');
    return blockChainRemoteDataSource.getBalance(address);
  }

  @override
  Future getTransactionDetail(String id) async {
    return blockChainRemoteDataSource.getTransactionDetail(id);
  }

  @override
  Future getTransactionHistory(String address) =>
      blockChainRemoteDataSource.getTransactionHistory(address);
}
