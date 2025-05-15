import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/app_constant.dart';

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
    required this.itemName,
    required this.itemCount,
    required this.imageUrl,
  });

  final String itemName;
  final int itemCount;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth =
            constraints.maxWidth < 600 ? 600 : constraints.maxWidth;
        return Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Image.network(imageUrl, height: 70.h, width: 70.w),
                      SizedBox(width: 10.w),
                      Text(
                        itemName,
                        style: TextStyle(
                          fontSize: maxWidth > 600 ? 20.sp : 14.sp,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(width: 220.w),
                Text(
                  itemCount.toString(),
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    decoration: TextDecoration.none,
                    fontSize: maxWidth > 600 ? 20.sp : 14.sp,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
