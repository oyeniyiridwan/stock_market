import 'package:stock/model/stock_response_model.dart';

class MainModel {
  Data2? data;

  MainModel({this.data});

  MainModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data2.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data2 {
  String? name;
  Eod? eod;

  Data2({this.name, this.eod});

  Data2.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    eod = json['eod'] != null ? new Eod.fromJson(json['eod']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.eod != null) {
      data['eod'] = this.eod!.toJson();
    }
    return data;
  }
}
