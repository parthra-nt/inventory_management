import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled/presentation/screens/add_item_screen.dart';
import 'package:untitled/presentation/widgets/dashboard_product_list.dart';
import 'package:untitled/presentation/widgets/stock_dialog.dart';
import 'package:untitled/providers/dashboard_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<void> fetchAllDashboardData() async {
    final provider = Provider.of<DashboardProvider>(context, listen: false);
    await provider.readItems();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => fetchAllDashboardData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder:
          (context, provider, child) => Scaffold(
            body:
                provider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                      onRefresh: fetchAllDashboardData,
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Items",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                InkWell(
                                  onTap:
                                      () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => AddItemScreen(),
                                        ),
                                      ),
                                  child: Text(
                                    "+ Add Items",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: CupertinoColors.activeBlue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          provider.productList?.isEmpty ?? true
                              ? Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 40.h),
                                  child: Text(
                                    'No Data Available',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              )
                              : ListView.builder(
                                itemCount: provider.productList?.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final item = provider.productList![index];
                                  return DashboardProductList(
                                    imageUrl: item['image_url'],
                                    itemCount: item['quantity'],
                                    itemName: item['name'],
                                    id: item['id'],
                                    onTap1:
                                        () => showDialog(
                                          context: context,
                                          builder:
                                              (context) => StockDialog(
                                                provider: provider,
                                                id: item['id'],
                                                quantity: item['quantity'],
                                                name: item['name'],
                                                isStockIn: true,
                                                stock: provider.stock,
                                              ),
                                        ),
                                    onTap2:
                                        () => showDialog(
                                          context: context,
                                          builder:
                                              (context) => StockDialog(
                                                provider: provider,
                                                id: item['id'],
                                                quantity: item['quantity'],
                                                name: item['name'],
                                                isStockIn: false,
                                                stock: provider.stock,
                                              ),
                                        ),
                                  );
                                },
                              ),
                        ],
                      ),
                    ),
          ),
    );
  }
}
