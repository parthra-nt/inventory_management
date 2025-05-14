
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/add_item_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mime/mime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:untitled/auth/auth_service.dart';


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
                                provider.image != null
                                    ? Image.memory(
                                      provider.image!,
                                      fit: BoxFit.cover,
                                    )
                                    : Placeholder(),
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
=======
  Uint8List? image;
  String? fileName;

  Future pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image,
      );
      if (result != null && result.files.single.path != null) {
        setState(() {
          image = result.files.single.bytes!;
          fileName = result.files.single.name;
        });
      }
    } on PlatformException catch (e) {
      print("Failed to Pick Image $e");
    }
  }

  Future<void> uploadImage(Uint8List? imageBytes, String? originalName) async {
    final fileExtension = originalName!.split('.').last;
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.$fileExtension';

    final mimeType = lookupMimeType(originalName);
    try {
      await AuthService().supabase.storage
          .from('images')
          .uploadBinary(
            'uploads/$fileName',
            image!,
            fileOptions: FileOptions(contentType: mimeType),
          );
      final publicUrl = AuthService().supabase.storage
          .from('images')
          .getPublicUrl('uploads/$fileName');
      print('✅ Upload successful: $publicUrl');
    } catch (e) {
      print('Upload failed: $e');
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
            onTap: () => uploadImage(image, fileName),
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
                              ? Image.memory(image!, fit: BoxFit.cover)
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
