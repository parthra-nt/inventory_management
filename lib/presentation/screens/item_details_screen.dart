import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemDetailsScreen extends StatefulWidget {
  const ItemDetailsScreen({super.key});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void bottomSheet1() {
    _scaffoldKey.currentState?.showBottomSheet((context) {
      return Container(
        height: 150,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 200),
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.arrow_down_square,
                          color: Color(0xff3c75ef),
                          size: 40,
                        ),
                        Text("Stock In", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                  Icon(CupertinoIcons.right_chevron),
                ],
              ),
            ),
            Divider(
              color: Colors.white38,
              indent: 1,
              endIndent: 1,
              thickness: 1,
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 200),
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.arrow_up_square,
                          color: Color(0xffdc3a3a),
                          size: 40,
                        ),
                        Text("Stock Out", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                  Icon(CupertinoIcons.right_chevron),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  void bottomSheet2() {
    _scaffoldKey.currentState?.showBottomSheet((context) {
      return Container(
        height: 150,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 200),
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: Color(0xff3c75ef), size: 30),
                        Text("Edit", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                  Icon(CupertinoIcons.right_chevron),
                ],
              ),
            ),
            Divider(
              color: Colors.white38,
              indent: 1,
              endIndent: 1,
              thickness: 1,
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 200),
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.delete,
                          color: Color(0xffdc3a3a),
                          size: 30,
                        ),
                        Text("Delete", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                  Icon(CupertinoIcons.right_chevron),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xffd2dffb),
        title: Text("Item"),
        actions: [
          Icon(Icons.edit_sharp),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: IconButton(
              onPressed: bottomSheet2,
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
                            "SKU",
                            style: TextStyle(
                              color: Color(0xff66676e),
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "UPKHDKJKA",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey, thickness: 1, endIndent: 1),
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
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey, thickness: 1, endIndent: 1),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Barcode",
                            style: TextStyle(
                              color: Color(0xff66676e),
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "123456789",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey, thickness: 1, endIndent: 1),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Category",
                            style: TextStyle(
                              color: Color(0xff66676e),
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "-",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey, thickness: 1, endIndent: 1),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 5,
            child: Container(
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
                    onTap: bottomSheet1,
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
          ),
        ],
      ),
    );
  }
}
