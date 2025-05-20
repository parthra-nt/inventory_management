import 'package:flutter/material.dart';
import 'package:untitled/auth/auth_service.dart';

class DashboardProvider extends ChangeNotifier {
  final TextEditingController stock = TextEditingController();
  bool isLoading = false;
  List? productList;
  final service = AuthService().supabase;
  bool isUpdatedStock = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int _quantity = 0;

  int get quantity => _quantity;

  set quantity(int value) {
    _quantity = value;
    notifyListeners();
  }

  Future<void> readItems() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await service.from('products').select();
      productList = response;
      notifyListeners();
    } catch (e) {
      print("Error Fetching List $e");
      productList = [];
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> updateStock(
    int quantity,
    int input,
    String productName,
    int id, {
    bool stockIn = true,
  }) async {
    try {
      final value = stockIn ? quantity + input : quantity - input;
      await service
          .from('products')
          .update({'quantity': value})
          .eq('name', productName)
          .select()
          .single();
      this.quantity = value;
      isUpdatedStock = true;
      notifyListeners();
      await service.from('transactions').insert({
        'product_id': id,
        'quantity': input,
        'type': stockIn ? 'in' : 'out',
      });
      notifyListeners();
    } catch (e) {
      print('Error Updating $e');
    }
  }
}
