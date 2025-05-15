import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
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
      builder:
          (context, provider, child) => Scaffold(
            body: SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
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
                              height: 50,
                              width: 100,
                              margin: EdgeInsets.only(left: 40),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
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
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: Text("ok"),
                                        ),
                                      ],
                                    ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 250.h),
                              child: Text(
                                "Save",
                                style: TextStyle(
                                  color: CupertinoColors.activeBlue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Item Name", style: TextStyle(fontSize: 20)),
                            Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: SizedBox(
                                width: 200,
                                height: 30,
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
                          Text("Quantity", style: TextStyle(fontSize: 20)),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: SizedBox(
                              width: 200,
                              height: 30,
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
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
