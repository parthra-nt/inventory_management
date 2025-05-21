import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled/constants/app_constant.dart';
import 'package:untitled/presentation/screens/dashboard_screen.dart';
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
        return LayoutBuilder(
          builder: (context, constraints) {
            double maxWidth = constraints.maxWidth;
            double contentWidth = maxWidth > 800 ? 700 : maxWidth;
            return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: contentWidth,
                      child: _buildImageSection(provider),
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: contentWidth,
                      child: _buildTextField(
                        "Item Name",
                        "Enter Item Name",
                        provider.name,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: contentWidth,
                      child: _buildTextField(
                        "Quantity",
                        "Enter Quantity",
                        provider.quantity,
                        isNumber: true,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Center(
                      child: _buildSaveButton(context, provider, contentWidth),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildImageSection(AddItemProvider provider) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: SizedBox(
            height: 80.h,
            width: 80.h,
            child:
                provider.image != null
                    ? Image.memory(provider.image!, fit: BoxFit.cover)
                    : SvgPicture.asset(
                      "assets/images/empty_image.svg",
                      fit: BoxFit.cover,
                    ),
          ),
        ),
        SizedBox(width: 16.w),
        GestureDetector(
          onTap: provider.pickImage,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey5,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              "Add Image",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: CupertinoColors.activeBlue,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller, {
    bool isNumber = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          style: TextStyle(fontSize: 20.sp),
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 10.h,
            ),
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(
    BuildContext context,
    AddItemProvider provider,
    double width,
  ) {
    return GestureDetector(
      onTap: () async {
        await provider.uploadImage(provider.image, provider.fileName);
        await provider.addItemTable();
        await showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                title: const Text("Item Added Successfully"),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => DashboardScreen()),
                      );
                    },
                    child: const Text("OK"),
                  ),
                ],
              ),
        );
      },
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Text(
            "Save",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
