import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/auth/auth_service.dart';

class ItemPageProvider extends ChangeNotifier {
  List? itemsList;
  bool isLoading = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int _quantity = 0;

  int get quantity => _quantity;

  set quantity(int value) {
    _quantity = value;
    notifyListeners();
  }

  void bottomSheet1(String id, Function() stockIn, Function() stockOut) {
    showModalBottomSheet(
      context: scaffoldKey.currentContext!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isDismissible: true,
      builder:
          (context) => Container(
            height: 150,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap:
                      () => showDialog(
                        context: context,
                        builder: (context) => stockIn(),
                      ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 200),
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.arrow_down_square,
                              color: Color(0xff3c75ef),
                              size: 40,
                            ),
                            Text("Stock In", style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                      Icon(CupertinoIcons.right_chevron),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.white38,
                  indent: 1,
                  endIndent: 1,
                  thickness: 1,
                ),
                GestureDetector(
                  onTap:
                      () => showDialog(
                        context: context,
                        builder: (context) => stockOut(),
                      ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 200),
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.arrow_up_square,
                              color: Color(0xffdc3a3a),
                              size: 40,
                            ),
                            Text("Stock Out", style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                      Icon(CupertinoIcons.right_chevron),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }

  void bottomSheet2(String name) {
    showModalBottomSheet(
      context: scaffoldKey.currentContext!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isDismissible: true,
      builder:
          (context) => Container(
            height: 150,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 200),
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color: Color(0xff3c75ef),
                              size: 30,
                            ),
                            Text("Edit", style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                      Icon(CupertinoIcons.right_chevron),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.white38,
                  indent: 1,
                  endIndent: 1,
                  thickness: 1,
                ),
                GestureDetector(
                  onTap: () {
                    deleteItem(name, context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 200),
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.delete,
                              color: Color(0xffdc3a3a),
                              size: 30,
                            ),
                            Text("Delete", style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                      Icon(CupertinoIcons.right_chevron),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Future<void> updateStock(
    int quantity,
    int input,
    String productName, {
    bool stockIn = true,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      final value = stockIn ? quantity + input : quantity - input;
      await AuthService().supabase
          .from('products')
          .update({'quantity': value})
          .eq('name', productName)
          .select()
          .single();
      this.quantity = value;
      notifyListeners();
    } catch (e) {
      print('Error Updating $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteItem(String name, BuildContext context) async {
    try {
      await AuthService().supabase.from('products').delete().eq('name', name);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Item Deletes")));
    } catch (e) {
      print("Error Deleting Item $e");
    }
  }

  Future<void> readItems() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await AuthService().supabase.from('products').select();
      itemsList = response;
    } catch (e) {
      print("Error Fetching List $e");
      itemsList = [];
    }
    isLoading = false;
    notifyListeners();
  }
}
