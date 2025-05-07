import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print("Failed to Pick Image $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Item",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 20),
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
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black12,
                      ),
                      child:
                          image != null
                              ? Image.file(image!, fit: BoxFit.cover)
                              : Placeholder(),
                    ),
                    GestureDetector(
                      onTap: pickImage,
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
                    Text("SKU", style: TextStyle(fontSize: 20)),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: SizedBox(
                        width: 200,
                        height: 30,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Enter SKU",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Category", style: TextStyle(fontSize: 20)),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: SizedBox(
                        width: 200,
                        height: 30,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Enter Category",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Description", style: TextStyle(fontSize: 20)),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: SizedBox(
                        width: 200,
                        height: 100,
                        child: TextField(
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: "Enter Item Description",
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
    );
  }
}
