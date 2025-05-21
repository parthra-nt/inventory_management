import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled/constants/app_constant.dart';
import 'package:untitled/presentation/widgets/transaction_widget.dart';
import 'package:untitled/providers/items_details_provider.dart';

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
  Future<void> fetchItmesAllData() async {
    final provider = Provider.of<ItemsDetailProvider>(context, listen: false);
    await provider.readTransactions(context, widget.id);
  }

  final TextEditingController stock = TextEditingController();
  final TextEditingController nameUpdate = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => fetchItmesAllData());
  }

  @override
  void dispose() {
    stock.dispose();
    nameUpdate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemsDetailProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          key: provider.scaffoldKey,
          backgroundColor: Colors.white,
          body:
              provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                    onRefresh: fetchItmesAllData,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double screenWidth = constraints.maxWidth;
                        bool isMobile = screenWidth < 600;
                        bool isTablet =
                            screenWidth >= 600 && screenWidth <= 1024;
                        bool isDesktop = screenWidth > 1024;

                        double contentWidth = isDesktop ? 800 : screenWidth;

                        return Center(
                          child: Container(
                            width: contentWidth,
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 16.w : 24.w,
                              vertical: 20.h,
                            ),
                            child: ListView(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    buildImageSection(provider),
                                    SizedBox(width: 20.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            provider.isUpdatedName
                                                ? provider.productName
                                                : widget.productName,
                                            style: TextStyle(
                                              fontSize: 24.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(height: 16.h),
                                          Text(
                                            'Stock: ${widget.quantity}',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor
                                            .withOpacity(0.1),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                        ),
                                      ),
                                      onPressed:
                                          () => provider.bottomSheet2(
                                            context,
                                            provider.productName,
                                            widget.id,
                                            widget.imageUrl,
                                            nameUpdate,
                                          ),
                                      child: Text(
                                        "Edit Item",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30.h),
                                Text(
                                  'Transaction History',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                if (provider.transactionList?.isEmpty ?? true)
                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 40.h,
                                      ),
                                      child: Text(
                                        'No Transactions Available',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  )
                                else
                                  ListView.builder(
                                    itemCount: provider.transactionList?.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final item =
                                          provider.transactionList![index];
                                      return TransactionWidget(
                                        date: item['timestamp'],
                                        quantity: item['quantity'],
                                        isStockIN: item['type'],
                                      );
                                    },
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
        );
      },
    );
  }

  Widget buildImageSection(ItemsDetailProvider provider) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Image.network(
        provider.isUpdatedImage ? provider.publicUrl : widget.imageUrl,
        height: 120.sp,
        width: 120.sp,
        fit: BoxFit.cover,
        errorBuilder:
            (context, error, stackTrace) => Icon(
              Icons.broken_image_outlined,
              size: 80.sp,
              color: Colors.grey,
            ),
      ),
    );
  }
}
