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
      builder:
          (context, provider, child) => Scaffold(
            key: provider.scaffoldKey,
            appBar: AppBar(
              backgroundColor: Color(0xffd2dffb),
              title: Text("Item"),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: IconButton(
                    onPressed:
                        () => provider.bottomSheet2(
                          context,
                          provider.productName,
                          widget.id,
                          nameUpdate,
                        ),
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
                      height: 250,
                      width: double.infinity,
                      color: Color(0xffd2dffb),
                      child: Image.network(widget.imageUrl, fit: BoxFit.cover),
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
                                  provider.productName,
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
                            provider.quantity.toString(),
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
                                  context,
                                  widget.id,
                                  () => stockDialog(
                                    widget.productName,
                                    provider.quantity.toString(),
                                    isStockIn: true,
                                  ),
                                  () => stockDialog(
                                    widget.productName,
                                    provider.quantity.toString(),
                                    isStockIn: false,
                                  ),
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

  Widget stockDialog(String name, String quantity, {bool isStockIn = true}) {
    var provider = Provider.of<ItemPageProvider>(context, listen: false);
    return AlertDialog(
      title:
          isStockIn
              ? Text("Enter The Quantity to Add Stock")
              : Text("Enter The Quantity to Remove from Stock"),
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
              var q = int.parse(quantity);
              await provider.updateStock(q, input, name, stockIn: isStockIn);
              stock.clear();
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ),
      ],
    );
  }
}
