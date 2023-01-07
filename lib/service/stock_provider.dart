import 'dart:convert';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
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
  List<StockModel> get stock {
    return [..._stock];
  }

  List<MainModel> get data {
    return [..._search];
  }

  String date = ((DateTime.now().hour >= 15 && DateTime.now().minute > 30) ||
          DateTime.now().hour > 15)
      ? DateFormat('yyyy-MM-dd').format(DateTime.now())
      : DateFormat('yyyy-MM-dd')
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
      'T',
      'BABA',
      'VOD',
      'JPM',
      'JNJ',
      'PG'
    ];
    symbols.shuffle();
    if (await ConnectivityWrapper.instance.isConnected) {
      try {
        for (int i = 0; i < 10; i++) {
          final url = Uri.parse(
              'http://api.marketstack.com/v1/tickers/${symbols[i]}/eod?access_key=98a9ab33764b153d7a9eddd8b914a79a&date_from=$dateFrom&date_to=$dateTo');
          var response = await http.get(url);
          final json = StockModel.fromJson(jsonDecode(response.body));
          if (response.statusCode == 200) {
            _stock.add(json);
          }
          notifyListeners();
        }
        if (_stock.isNotEmpty) {
          mainData();
          print(date);
        } else {
          Fluttertoast.showToast(
              msg: 'An Error occurred',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.white,
              textColor: Colors.black87,
              fontSize: 16.0);
        }
      } catch (e) {
        rethrow;
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Device is Offline',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.black87,
          fontSize: 16.0);
    }
  }

  void pickedDate(String newDate) {
    date = newDate;
    mainData();
    notifyListeners();
  }

  void mainData() {
    _data = [];
    for (int i = 0; i < _stock.length; i++) {
      if(_stock[i].data!.eod!.any((element) => element!.date!.contains(date))){
      _data.add(MainModel(
          data: Data2(
              name: _stock[i].data!.name,
              eod: _stock[i]
                  .data!
                  .eod!
                  .firstWhere((eod) => eod.date!.contains(date)))));}
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

