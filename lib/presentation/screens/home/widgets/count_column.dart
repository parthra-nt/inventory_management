import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:untitled/models/stock_count_model.dart';
import 'package:untitled/presentation/screens/home/widgets/stock_count_row.dart';

import '../../../../constants/app_constant.dart';

class CountColumn extends StatelessWidget {
  const CountColumn({super.key, required this.model});

  final StockCountModel model;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth =
            constraints.maxWidth < 600 ? 600 : constraints.maxWidth;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  model.title,
                  style: AppTextTheme.cardBoldTextStyle.copyWith(
                    fontSize: maxWidth > 600 ? 20.sp : 14.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  DateFormat('MMMM d, yyyy').format(model.date),
                  style: AppTextTheme.cardSmallTextStyle.copyWith(
                    fontSize: maxWidth > 600 ? 14.sp : 12.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StockCountRow(count: '${model.total}', title: "Total"),
                StockCountRow(count: "${model.stockIn}", title: "Stock In"),
                StockCountRow(
                  count: "${model.stockOut}",
                  title: "Stock Out",
                  isLast: true,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
