import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/app_constant.dart';

class StockCountRow extends StatelessWidget {
  const StockCountRow({
    super.key,
    required this.count,
    required this.title,
    this.isLast = false,
  });

  final String count;
  final String title;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth =
            constraints.maxWidth > 600 ? 600 : constraints.maxWidth;
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  count,
                  style: AppTextTheme.cardBoldTextStyle.copyWith(
                    fontSize: maxWidth > 600 ? 24.sp : 14.sp,
                  ),
                ),
                Text(
                  title,
                  style: AppTextTheme.cardSmallTextStyle.copyWith(
                    fontSize: maxWidth > 600 ? 16.sp : 14.sp,
                  ),
                ),
              ],
            ),
            isLast
                ? SizedBox()
                : SizedBox(
                  height: 50.h,
                  child: VerticalDivider(
                    color: Color(0xff5586EE),
                    indent: 5.h,
                    endIndent: 2.h,
                    thickness: 2.w,
                  ),
                ),
          ],
        );
      },
    );
  }
}
