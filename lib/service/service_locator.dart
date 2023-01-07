import 'package:get_it/get_it.dart';
import 'package:stock/service/stock_provider.dart';
final GetIt getIt = GetIt.instance;
void setup(){
  getIt.registerLazySingleton(() => StockProvider());
}