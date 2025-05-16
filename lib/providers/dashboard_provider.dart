import 'package:flutter/foundation.dart';
import 'package:untitled/auth/auth_service.dart';
import 'package:untitled/models/stock_count_model.dart';

class DashboardProvider extends ChangeNotifier {
  bool isLoading = false;
  List? productList;

  final List<StockCountModel> stockCountModel = [
    StockCountModel(
      title: 'Today',
      date: DateTime.now(),
      total: 345,
      stockIn: 344,
      stockOut: 43,
    ),
    StockCountModel(
      title: 'Yesterday',
      date: DateTime.now().subtract(Duration(days: 1)),
      total: 345,
      stockIn: 344,
      stockOut: 43,
    ),
  ];

  Future<void> readItems() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await AuthService().supabase
          .from('products')
          .select()
          .limit(6);
      productList = response;
    } catch (e) {
      print("Error Fetching List $e");
      productList = [];
    }
    isLoading = false;
    notifyListeners();
  }
}
