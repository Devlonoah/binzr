import 'item_model.dart';

class Data {
  String? address;
  String? updatedAt;
  String? nextUpdateAt;
  String? quoteCurrency;
  int? chainId;
  List<Items>? items;
  Null? pagination;

  Data(
      {this.address,
      this.updatedAt,
      this.nextUpdateAt,
      this.quoteCurrency,
      this.chainId,
      this.items,
      this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    updatedAt = json['updated_at'];
    nextUpdateAt = json['next_update_at'];
    quoteCurrency = json['quote_currency'];
    chainId = json['chain_id'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    pagination = json['pagination'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['address'] = this.address;
    data['updated_at'] = this.updatedAt;
    data['next_update_at'] = this.nextUpdateAt;
    data['quote_currency'] = this.quoteCurrency;
    data['chain_id'] = this.chainId;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['pagination'] = this.pagination;
    return data;
  }
}
