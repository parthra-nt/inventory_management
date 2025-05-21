import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/providers/dashboard_provider.dart';

class StockDialog extends StatelessWidget {
  const StockDialog({
    super.key,
    this.isStockIn = true,
    required this.name,
    required this.stock,
    required this.quantity,
    required this.id,
    required this.provider,
  });

  final bool isStockIn;
  final TextEditingController stock;
  final String name;
  final int quantity;
  final int id;
  final DashboardProvider provider;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title:
          isStockIn
              ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/images/stockIn.svg",
                      height: 20.h,
                      width: 20.w,
                      theme: SvgTheme(currentColor: Color(0xff3c75ef)),
                    ),
                  ),
                  Text(
                    "Enter Stock In quantity",
                    style: TextStyle(fontSize: 20.sp),
                  ),
                ],
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/images/stockOut.svg",
                      height: 20.h,
                      width: 20.w,
                      theme: SvgTheme(currentColor: Color(0xffdc3a3a)),
                    ),
                  ),
                  Text(
                    "Enter Stock Out quantity",
                    style: TextStyle(fontSize: 20.sp),
                  ),
                ],
              ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: [
        TextField(
          controller: stock,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                color: CupertinoColors.activeBlue,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                color: CupertinoColors.activeBlue,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            SizedBox(width: 30.w),
            ElevatedButton(
              onPressed: () async {
                if (stock.text.isEmpty || int.tryParse(stock.text) == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Enter valid quantity")),
                  );
                  return;
                }
                var input = int.parse(stock.text);
                await provider.updateStock(
                  quantity,
                  input,
                  name,
                  id,
                  stockIn: isStockIn,
                );
                Navigator.pop(context);
                stock.clear();
              },
              child: Text("Save"),
            ),
          ],
        ),
      ],
    );
  }
}
