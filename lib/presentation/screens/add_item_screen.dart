import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled/constants/app_constant.dart';
import 'package:untitled/presentation/screens/main_home_screen.dart';
import 'package:untitled/providers/add_item_provider.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddItemProvider>(
      builder: (context, provider, child) {
        final height = MediaQuery.sizeOf(context).height;
        final width = MediaQuery.sizeOf(context).width;
        return Scaffold(
          body: Center(
            child: Container(
              height: height * 0.36,
              width: width * 0.625,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xffeaeaea),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100.h,
                        width: 100.w,
                        child:
                            provider.image != null
                                ? Image.memory(
                                  provider.image!,
                                  fit: BoxFit.cover,
                                )
                                : Image.asset(
                                  "assets/images/items/empty_image.png",
                                  fit: BoxFit.fitHeight,
                                ),
                      ),
                      GestureDetector(
                        onTap: provider.pickImage,
                        child: Container(
                          height: 50.h,
                          width: 100.w,
                          margin: EdgeInsets.only(left: 100.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.black12,
                          ),
                          child: Center(
                            child: Text(
                              "Add Image",
                              style: TextStyle(
                                color: CupertinoColors.systemBlue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Item Name", style: TextStyle(fontSize: 20.sp)),
                        Padding(
                          padding: EdgeInsets.only(right: 30.w),
                          child: SizedBox(
                            width: 200.w,
                            height: 30.h,
                            child: TextField(
                              controller: provider.name,
                              decoration: InputDecoration(
                                hintText: "Enter Item Name",
                                border: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 1, indent: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Quantity", style: TextStyle(fontSize: 20.sp)),
                      Padding(
                        padding: EdgeInsets.only(right: 30.w),
                        child: SizedBox(
                          width: 200.w,
                          height: 30.h,
                          child: TextField(
                            controller: provider.quantity,
                            decoration: InputDecoration(
                              hintText: "Enter Quantity",
                              border: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(thickness: 1, indent: 1),
                  GestureDetector(
                    onTap: () async {
                      await provider.uploadImage(
                        provider.image,
                        provider.fileName,
                      );
                      await provider.addItemTable();
                      await showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              title: Text("Item Added Successfully"),
                              actions: [
                                ElevatedButton(
                                  onPressed:
                                      () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => MainHomeScreen(),
                                        ),
                                      ),
                                  child: Text("ok"),
                                ),
                              ],
                            ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.scaffoldBackColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            spreadRadius: 0.5,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: CupertinoColors.activeBlue,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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
