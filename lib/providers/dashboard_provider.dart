import 'package:flutter/foundation.dart';
import 'package:untitled/auth/auth_service.dart';
import 'package:untitled/models/stock_count_model.dart';

class DashboardProvider extends ChangeNotifier {
  bool isLoading = false;
  List? productList;
  List<StockCountModel> stockCountModel = [
    StockCountModel(
      title: 'Today',
      date: DateTime.now(),
      total: 345,
      stockIn: 0,
      stockOut: 0,
    ),
    StockCountModel(
      title: 'Yesterday',
      date: DateTime.now().subtract(Duration(days: 1)),
      total: 345,
      stockIn: 344,
      stockOut: 43,
    ),
  ];

  int _totalStock = 0;

  int get totalStock => _totalStock;

  set totalStock(int i) {
    _totalStock = i;
  }

  int _totalStockIn = 0;

  int get totalStockIn => _totalStockIn;

  set totalStockIn(int i) {
    _totalStockIn = i;
  }

  int _totalStockOut = 0;

  int get totalStockOut => _totalStockOut;

  set totalStockOut(int i) {
    _totalStockOut = i;
  }

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

  Future<int> getTotalStockInToday() async {
    try {
      final now = DateTime.now();
      final startOfDay =
          DateTime(now.year, now.month, now.day).toIso8601String();
      final endOfDay =
          DateTime(now.year, now.month, now.day, 23, 59, 59).toIso8601String();

      final response = await AuthService().supabase
          .from('transaction')
          .select('quantity, timestamp')
          .gte('timestamp', startOfDay)
          .lte('timestamp', endOfDay)
          .eq('type', 'in');
      final List data = response;
      int total = data.fold<int>(0, (sum, item) {
        final int qty =
            item['quantity'] is String
                ? int.tryParse(item['quantity']) ?? 0
                : item['quantity'] ?? 0;
        return sum + qty;
      });
      totalStockIn = total;
      notifyListeners();
      return total;
    } catch (e) {
      print('Error fetching transaction data: $e');
      return 0;
    }
  }

  Future<int> getTotalStockOutToday() async {
    try {
      final now = DateTime.now();
      final startOfDay =
          DateTime(now.year, now.month, now.day).toIso8601String();
      final endOfDay =
          DateTime(now.year, now.month, now.day, 23, 59, 59).toIso8601String();

      final response = await AuthService().supabase
          .from('transaction')
          .select('quantity, timestamp')
          .gte('timestamp', startOfDay)
          .lte('timestamp', endOfDay)
          .eq('type', 'out');
      final List data = response;
      int total = data.fold<int>(0, (sum, item) {
        final int qty =
            item['quantity'] is String
                ? int.tryParse(item['quantity']) ?? 0
                : item['quantity'] ?? 0;
        return sum + qty;
      });
      totalStockOut = total;
      notifyListeners();
      return total;
    } catch (e) {
      print('Error fetching transaction data: $e');
      return 0;
    }
  }

  Future<void> getTotalItem() async {
    try {
      final countResponse =
          await AuthService().supabase.from('products').select('*').count();
      totalStock = countResponse.count;
      notifyListeners();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
