import 'package:crypto_wallet/models/balance_model.dart';

abstract class IwalletAccess {
  ///* getBalance
  Future<BalanceModel> getBalance(String address);

  ///* Get Transaction history for address
  Future<dynamic> getTransactionHistory(String address);

  ///* Get a transaction detail for transaction -XYZ- ( - specified trxn id)

  Future<dynamic> getTransactionDetail(String id);
}
