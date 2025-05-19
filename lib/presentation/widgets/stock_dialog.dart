import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/item_page_provider.dart';

class StockDialog extends StatelessWidget {
  StockDialog({
    super.key,
    this.isStockIn = true,
    required this.name,
    required this.stock,
    required this.quantity,
    required this.id,
  });

  bool isStockIn;
  final TextEditingController stock;
  final String name;
  final int quantity;
  final int id;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ItemPageProvider>(context, listen: false);
    return AlertDialog(
      backgroundColor: Colors.white,
      title:
          isStockIn
              ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Text("Enter Stock In quantity"),
                ],
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  Text("Enter Stock Out quantity"),
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () async {
              if (stock.text.isEmpty || int.tryParse(stock.text) == null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Enter valid quantity")));
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
        ),
      ],
    );
  }
}
