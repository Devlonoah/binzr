import 'data_model.dart';

class BalanceModel {
  Data? data;
  bool? error;
  String? errorMessage;
  String? errorCode;

  BalanceModel({this.data, this.error, this.errorMessage, this.errorCode});

  BalanceModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'];
    errorMessage = json['error_message'];
    errorCode = json['error_code'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = this.error;
    data['error_message'] = this.errorMessage;
    data['error_code'] = this.errorCode;
    return data;
  }
}
