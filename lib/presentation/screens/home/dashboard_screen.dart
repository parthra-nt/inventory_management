import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled/presentation/screens/home/widgets/count_column.dart';
import 'package:untitled/presentation/screens/home/widgets/item_list.dart';
import 'package:untitled/providers/dashboard_provider.dart';

import '../../../constants/app_constant.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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

                  ///title and add item button
                  Padding(
                    padding: EdgeInsets.only(
                      left: 5.w,
                      top: 12.w,
                      bottom: 12.w,
                    ),
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
                              (context, index) => ItemList(
                                imageUrl:
                                    provider.productList![index]['image_url'],
                                itemCount:
                                    provider.productList![index]['quantity'],
                                itemName: provider.productList![index]['name'],
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
