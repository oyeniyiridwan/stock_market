import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stock/my_home_page.dart';
import 'package:stock/service/service_locator.dart';
import 'package:stock/service/stock_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  StockProvider stock =  GetIt.instance.get<StockProvider>();
  await stock.getStock();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: stock),
        ],
    child:const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
