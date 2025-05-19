import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants/app_constant.dart';

class DashboardProductList extends StatelessWidget {
  const DashboardProductList({
    super.key,
    required this.itemName,
    required this.itemCount,
    required this.imageUrl,
    required this.id,
    required this.onTap1,
    required this.onTap2,
  });

  final String itemName;
  final int itemCount;
  final String imageUrl;
  final int id;
  final VoidCallback onTap1;
  final VoidCallback onTap2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image section
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                imageUrl,
                height: 60.h,
                width: 60.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "$itemCount Items",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            // Action buttons
            Row(
              children: [
                GestureDetector(
                  onTap: onTap1,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color(0xffe6f0ff),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/images/stockIn.svg",
                      height: 20.h,
                      width: 20.w,
                      theme: SvgTheme(currentColor: Color(0xff3c75ef)),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: onTap2,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color(0xffffe6e6),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/images/stockOut.svg",
                      height: 20.h,
                      width: 20.w,
                      theme: SvgTheme(currentColor: Color(0xffdc3a3a)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
