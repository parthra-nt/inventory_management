import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled/presentation/screens/add_item_screen.dart';
import 'package:untitled/presentation/screens/home/widgets/count_column.dart';
import 'package:untitled/presentation/screens/home/widgets/dashboard_product_list.dart';
import 'package:untitled/presentation/widgets/stock_dialog.dart';
import 'package:untitled/providers/dashboard_provider.dart';

import '../../../constants/app_constant.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<void> fetchAllDashboardData() async {
    final provider = Provider.of<DashboardProvider>(context, listen: false);
    await provider.readItems();
    await provider.getTotalStockInToday(); // Assuming these are async
    await provider.getTotalStockOutToday();
    await provider.getTotalItem();
  }

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<DashboardProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) => provider.readItems());
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => provider.getTotalStockInToday(),
    );
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => provider.getTotalStockOutToday(),
    );
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => provider.getTotalItem(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder:
          (context, provider, child) => SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Column(
                children: [
                  /// Count Container
                  Container(
                    height: 120.h,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    padding: EdgeInsets.only(left: 18.w, top: 12.h),
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return CountColumn(
                          title: "Today",
                          date: DateTime.now(),
                          totalStock: provider.totalStock,
                          totalStockIn: provider.totalStockIn,
                          totalStockOut: provider.totalStockOut,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
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
                        GestureDetector(
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
                  provider.isLoading
                      ? CircularProgressIndicator()
                      : provider.productList?.isEmpty ?? true
                      ? Text("Not Data")
                      : SingleChildScrollView(
                        child: ListView.builder(
                          itemCount: provider.productList?.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder:
                              (context, index) => DashboardProductList(
                                imageUrl:
                                    provider.productList![index]['image_url'],
                                itemCount:
                                    provider.productList![index]['quantity'],
                                itemName: provider.productList![index]['name'],
                                id: provider.productList![index]['id'],
                                onTap1:
                                    () => showDialog(
                                      context: context,
                                      builder:
                                          (context) => StockDialog(
                                            id:
                                                provider
                                                    .productList![index]['id'],
                                            quantity:
                                                provider
                                                    .productList![index]['quantity'],
                                            name:
                                                provider
                                                    .productList![index]['name'],
                                            isStockIn: true,
                                            stock: provider.stock,
                                          ),
                                    ),
                                onTap2:
                                    () => showDialog(
                                      context: context,
                                      builder:
                                          (context) => StockDialog(
                                            id:
                                                provider
                                                    .productList![index]['id'],
                                            quantity:
                                                provider
                                                    .productList![index]['quantity'],
                                            name:
                                                provider
                                                    .productList![index]['name'],
                                            isStockIn: false,
                                            stock: provider.stock,
                                          ),
                                    ),
                              ),
                        ),
                      ),
                ],
              ),
            ),
          ),
    );
  }
}
