class Items {
  int? contractDecimals;
  String? contractName;
  String? contractTickerSymbol;
  String? contractAddress;
  String? logoUrl;
  String? lastTransferredAt;
  String? type;
  String? balance;
  String? balance24h;
  double? quoteRate;
  double? quoteRate24h;
  double? quote;
  double? quote24h;
  Null? nftData;

  Items(
      {this.contractDecimals,
      this.contractName,
      this.contractTickerSymbol,
      this.contractAddress,
      this.logoUrl,
      this.lastTransferredAt,
      this.type,
      this.balance,
      this.balance24h,
      this.quoteRate,
      this.quoteRate24h,
      this.quote,
      this.quote24h,
      this.nftData});

  Items.fromJson(Map<String, dynamic> json) {
    contractDecimals = json['contract_decimals'];
    contractName = json['contract_name'];
    contractTickerSymbol = json['contract_ticker_symbol'];
    contractAddress = json['contract_address'];

    logoUrl = json['logo_url'];
    lastTransferredAt = json['last_transferred_at'];
    type = json['type'];
    balance = json['balance'];
    balance24h = json['balance_24h'];
    quoteRate = json['quote_rate'];
    quoteRate24h = json['quote_rate_24h'];
    quote = json['quote'];
    quote24h = json['quote_24h'];
    nftData = json['nft_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contract_decimals'] = this.contractDecimals;
    data['contract_name'] = this.contractName;
    data['contract_ticker_symbol'] = this.contractTickerSymbol;
    data['contract_address'] = this.contractAddress;
    data['logo_url'] = this.logoUrl;
    data['last_transferred_at'] = this.lastTransferredAt;
    data['type'] = this.type;
    data['balance'] = this.balance;
    data['balance_24h'] = this.balance24h;
    data['quote_rate'] = this.quoteRate;
    data['quote_rate_24h'] = this.quoteRate24h;
    data['quote'] = this.quote;
    data['quote_24h'] = this.quote24h;
    data['nft_data'] = this.nftData;
    return data;
  }
}
