import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled/constants/app_constant.dart';
import 'package:untitled/presentation/widgets/stock_dialog.dart';
import 'package:untitled/providers/item_page_provider.dart';

class ItemDetailsScreen extends StatefulWidget {
  const ItemDetailsScreen({
    super.key,
    required this.id,
    required this.productName,
    required this.quantity,
    required this.imageUrl,
  });

  final String productName;
  final int quantity;
  final String imageUrl;
  final int id;

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  final TextEditingController stock = TextEditingController();
  final TextEditingController nameUpdate = TextEditingController();

  @override
  void dispose() {
    stock.dispose();
    nameUpdate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemPageProvider>(
      builder: (context, provider, child) {
        final width = MediaQuery.sizeOf(context).width;
        final height = MediaQuery.sizeOf(context).height;
        return Scaffold(
          key: provider.scaffoldKey,
          body: Center(
            child: Container(
              height: height * 0.31,
              width: width * 0.625,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xffeaeaea),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 100.h,
                    width: 120.w,
                    child: Image.network(
                      provider.isUpdateImage
                          ? provider.publicUrl
                          : widget.imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Product Name",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        provider.productName,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                  Divider(indent: 1, thickness: 1, color: Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Quantity",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        provider.quantity.toString(),
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap:
                            () => provider.bottomSheet2(
                              context,
                              provider.productName,
                              widget.id,
                              widget.imageUrl,
                              nameUpdate,
                            ),
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.all(10),
                          height: 50.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                            color: Color(0xffeaf0fd),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Edit Item",
                              style: TextStyle(
                                color: Color(0xff4279f0),
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap:
                            () => provider.bottomSheet1(
                              context,
                              widget.id,
                              () => StockDialog(
                                isStockIn: true,
                                stock: stock,
                                name: widget.productName,
                                quantity: provider.quantity,
                                id: widget.id,
                              ),
                              () => StockDialog(
                                isStockIn: false,
                                name: widget.productName,
                                quantity: provider.quantity,
                                id: widget.id,
                                stock: stock,
                              ),
                            ),
                        child: Container(
                          margin: EdgeInsets.only(left: 10, top: 20),
                          padding: EdgeInsets.all(10),
                          height: 50.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                            color: Color(0xffeaf0fd),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Stock In/Out",
                              style: TextStyle(
                                color: Color(0xff4279f0),
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
