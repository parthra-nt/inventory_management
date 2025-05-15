import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/app_constant.dart';

class StockInOutButton extends StatelessWidget {
  const StockInOutButton({
    super.key,
    required this.title,
    required this.icon,
    required this.ontap,
  });

  final String title;
  final IconData icon;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth =
            constraints.maxWidth > 700 ? 700 : constraints.maxWidth;
        return GestureDetector(
          onTap: ontap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color:
                          title == "Stock Out"
                              ? Colors.red.shade50
                              : AppColors.iconBackColor,
                    ),
                    child: Icon(
                      icon,
                      color: title == "Stock Out" ? Colors.red : null,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(right: 40.0.w),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: maxWidth >= 600 ? 5.sp : 14.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
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
