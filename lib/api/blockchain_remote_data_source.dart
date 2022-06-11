import 'dart:convert';
import 'dart:io';

import 'package:crypto_wallet/api/i_wallet_access.dart';
import 'package:crypto_wallet/models/balance_model.dart';
import 'package:crypto_wallet/utils/configuration.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class BlockChainRemoteDataSource implements IwalletAccess {
  BlockChainRemoteDataSource(this.client, this.configuration);

  final http.Client client;

  final Configuration configuration;

  final baseUrl = "https://api.covalenthq.com/v1/1";
  final app_key = dotenv.env['app_key'];

  final _header = {
    HttpHeaders.acceptHeader: "application/json",
  };
  @override
  Future<BalanceModel> getBalance(String address) async {
    print('wallet address passed for fetching is $address');
    http.Response response = await http.get(
        Uri.parse("$baseUrl/address/$address/balances_v2/?&key=$app_key"),
        headers: _header);

    print(response.body);
    print("status code  ${response.statusCode}");
    print('response from balance is ${response.body}');
    return BalanceModel.fromJson(jsonDecode(response.body));
  }

  @override
  Future getTransactionHistory(String address) async {
    final _uri = Uri.parse(
        baseUrl + ":1/address/$address/transactions_v2/?&key=$app_key");

    http.Response response = await http.get(_uri, headers: _header);
  }

  @override
  Future getTransactionDetail(String trxnHash) async {
    final uri = Uri.parse(baseUrl + "transaction_v2/$trxnHash/?key=$app_key");
    http.Response response = await http.get(uri, headers: _header);
    throw UnimplementedError();
  }
}
