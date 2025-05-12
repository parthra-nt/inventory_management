import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  final String quantity;
  final String imageUrl;
  final String id;

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemPageProvider>(
      builder:
          (context, provider, child) => Scaffold(
            key: provider.scaffoldKey,
            appBar: AppBar(
              backgroundColor: Color(0xffd2dffb),
              title: Text("Item"),
              actions: [
                Icon(Icons.edit_sharp),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: IconButton(
                    onPressed: () => provider.bottomSheet2,
                    icon: Icon(Icons.more_vert),
                  ),
                ),
              ],
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      height: 180,
                      width: double.infinity,
                      color: Color(0xffd2dffb),
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Product Name",
                                  style: TextStyle(
                                    color: Color(0xff66676e),
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "123456789",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 1,
                            endIndent: 1,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 80,
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(
                            "60",
                            style: TextStyle(
                              fontSize: 24,
                              color: CupertinoColors.systemBlue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "Quantity",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap:
                                () => provider.bottomSheet1(
                                  widget.id,
                                  stock,
                                  stock,
                                ),
                            child: Container(
                              margin: EdgeInsets.only(left: 120),
                              padding: EdgeInsets.all(10),
                              height: 75,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Color(0xffeaf0fd),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Stock In/Out",
                                  style: TextStyle(
                                    color: Color(0xff4279f0),
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  Widget stock() {
    return AlertDialog();
  }
}
