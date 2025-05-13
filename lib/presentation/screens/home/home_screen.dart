import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/models/stock_count_model.dart';
import 'package:untitled/presentation/screens/home/widgets/count_column.dart';
import 'package:untitled/presentation/screens/home/widgets/item_list.dart';
import '../../../constants/app_constant.dart';

class HomeWebScreen extends StatelessWidget {
  HomeWebScreen({super.key});
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth =
            constraints.maxWidth < 800 ? 800 : constraints.maxWidth;
        double height =
            constraints.maxHeight < 400 ? 400 : constraints.maxHeight;
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: maxWidth > 800 ? 500.w : 50.w,
              vertical: 50.h,
            ),
            child: Column(
              children: [
                /// Count Container
                Container(
                  height: maxWidth > 800 ? 120.h : 100.h,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  padding: EdgeInsets.only(left: 18.w, top: 12.h),
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return CountColumn(model: stockCountModel[index]);
                    },
                  ),
                ),
                SizedBox(height: 20.h),

                ///title and add item button
                Padding(
                  padding: EdgeInsets.only(left: 5.w, top: 12.w, bottom: 12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Items",
                        style: TextStyle(
                          fontSize: maxWidth > 800 ? 20.sp : 14.sp,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        label: Text(
                          "Add item",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w700,
                            fontSize: maxWidth > 800 ? 20.sp : 14.sp,
                          ),
                        ),
                        icon: Icon(
                          Icons.add,
                          size: maxWidth > 800 ? 22.sp : 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                /// Item List
                ItemList(
                  itemName: "Microsoft Surface 4",
                  itemCount: 80,
                  imageUrl: "assets/images/items/macbook.png",
                ),
                ItemList(
                  itemName: "Microsoft Surface 4",
                  itemCount: 80,
                  imageUrl: "assets/images/items/macbook.png",
                ),
                ItemList(
                  itemName: "Microsoft Surface 4",
                  itemCount: 80,
                  imageUrl: "assets/images/items/macbook.png",
                ),
                ItemList(
                  itemName: "Microsoft Surface 4",
                  itemCount: 80,
                  imageUrl: "assets/images/items/macbook.png",
                ),
                ItemList(
                  itemName: "Microsoft Surface 4",
                  itemCount: 80,
                  imageUrl: "assets/images/items/macbook.png",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
