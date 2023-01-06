class StockModel {
  Pagination? pagination;
  Data? data;

  StockModel({this.pagination, this.data});

  StockModel.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Pagination {
  int? limit;
  int? offset;
  int? count;
  int? total;

  Pagination({this.limit, this.offset, this.count, this.total});

  Pagination.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    offset = json['offset'];
    count = json['count'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    data['count'] = this.count;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  String? name;
  String? symbol;
  bool? hasIntraday;
  bool? hasEod;
  Null? country;
  List<Eod>? eod;

  Data(
      {this.name,
      this.symbol,
      this.hasIntraday,
      this.hasEod,
      this.country,
      this.eod});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
    hasIntraday = json['has_intraday'];
    hasEod = json['has_eod'];
    country = json['country'];
    if (json['eod'] != null) {
      eod = <Eod>[];
      json['eod'].forEach((v) {
        eod!.add(new Eod.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['has_intraday'] = this.hasIntraday;
    data['has_eod'] = this.hasEod;
    data['country'] = this.country;
    if (this.eod != null) {
      data['eod'] = this.eod!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Eod {
  double? open;
  double? high;
  double? low;
  double? close;
  double? volume;
  double? adjHigh;
  double? adjLow;
  double? adjClose;
  double? adjOpen;
  double? adjVolume;
  double? splitFactor;
  double? dividend;
  String? symbol;
  String? exchange;
  String? date;

  Eod(
      {this.open,
      this.high,
      this.low,
      this.close,
      this.volume,
      this.adjHigh,
      this.adjLow,
      this.adjClose,
      this.adjOpen,
      this.adjVolume,
      this.splitFactor,
      this.dividend,
      this.symbol,
      this.exchange,
      this.date});

  Eod.fromJson(Map<String, dynamic> json) {
    open = json['open'];
    high = json['high'];
    low = json['low'];
    close = json['close'];
    volume = json['volume'];
    adjHigh = json['adj_high'];
    adjLow = json['adj_low'];
    adjClose = json['adj_close'];
    adjOpen = json['adj_open'];
    adjVolume = json['adj_volume'];
    splitFactor = json['split_factor'];
    dividend = json['dividend'];
    symbol = json['symbol'];
    exchange = json['exchange'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['open'] = this.open;
    data['high'] = this.high;
    data['low'] = this.low;
    data['close'] = this.close;
    data['volume'] = this.volume;
    data['adj_high'] = this.adjHigh;
    data['adj_low'] = this.adjLow;
    data['adj_close'] = this.adjClose;
    data['adj_open'] = this.adjOpen;
    data['adj_volume'] = this.adjVolume;
    data['split_factor'] = this.splitFactor;
    data['dividend'] = this.dividend;
    data['symbol'] = this.symbol;
    data['exchange'] = this.exchange;
    data['date'] = this.date;
    return data;
  }
}
