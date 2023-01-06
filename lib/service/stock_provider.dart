import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:stock/model/stock_main_model.dart';
import 'package:stock/model/stock_response_model.dart';
import 'package:http/http.dart' as http;

class StockProvider with ChangeNotifier {
  List<StockModel> _stock = [];
  List<MainModel> _data = [];
  List<MainModel> _search = [];

  List<MainModel> get data {
    return [..._search];
  }

  String date = DateFormat('yyyy-MM-dd')
      .format(DateTime.now().subtract(const Duration(days: 1)));

  Future<void> getStock() async {
    final dateTo = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final dateFrom = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().subtract(const Duration(days: 140)));
    List<String> symbols = [
      'AMZN',
      'AAPL',
      'MSFT',
      'GOOGL',
      'FB',
      'BRK.A',
      'VOD',
      'JPM',
      'JNJ',
      'PG'
    ];
    symbols.shuffle();
    // final queryParameters = {
    //   'access_key': '58ea9a89e96f7786bf147b2671e0968f',
    //   'date_from': dateFrom,
    //   'date_to': dateTo,
    // };

    for (int i = 0; i < 2; i++) {
      try {
        final url = Uri.parse(
            'http://api.marketstack.com/v1/tickers/${symbols[i]}/eod?access_key=da1e556bdb3de20985c492739e3d4bfd&date_from=$dateFrom&date_to=$dateTo');
        var response = await http.get(url);
        print(response.statusCode);
        final json = StockModel.fromJson(jsonDecode(response.body));
        // _data.add(MainModel(data: Data2(
        //   name: json.data!.name,
        //   eod:  json.data!.eod!.firstWhere((eod) => eod.date!.contains(date))
        // )
        // ));
        // print(data[i].data!.eod!.volume);
        _stock.add(json);
        notifyListeners();
      } catch (e) {
        Fluttertoast.showToast(
            msg: 'Pls put location on',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.white,
            textColor: Colors.black87,
            fontSize: 16.0);
        rethrow;
      }
    }
    mainData();
  }

  void pickedDate(String newDate) {
    date = newDate;
    mainData();
    notifyListeners();
  }

  void mainData() {
    _data = [];
    for (int i = 0; i < 2; i++) {
      _data.add(MainModel(
          data: Data2(
              name: _stock[i].data!.name,
              eod: _stock[i]
                  .data!
                  .eod!
                  .firstWhere((eod) => eod.date!.contains(date)))));
    }
    _search = _data;
    notifyListeners();
  }

  void search(value) {
    if (value.isEmpty) {
      _search = _data;
    } else {
      _search = _data
          .where((e) => e.data!.name!.toLowerCase().contains(value))
          .toList();
    }
    notifyListeners();
  }
}
