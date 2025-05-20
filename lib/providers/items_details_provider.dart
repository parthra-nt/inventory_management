import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mime/mime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:untitled/auth/auth_service.dart';
import 'package:untitled/presentation/screens/dashboard_screen.dart';
import 'package:untitled/presentation/widgets/bottom_sheet_option.dart';
import 'package:untitled/presentation/widgets/delete_dialog.dart';

class ItemsDetailProvider extends ChangeNotifier {
  final service = AuthService().supabase;
  Uint8List? image;
  String? fileName;
  String publicUrl = '';
  List? transactionList;
  bool isLoading = false;
  bool isUpdatedImage = false;
  bool isUpdatedName = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String _productName = '';

  String get productName => _productName;

  set productName(String name) {
    _productName = name;
    notifyListeners();
  }

  void bottomSheet2(
    BuildContext context,
    String name,
    int id,
    String imageUrl,
    TextEditingController nameTC,
  ) {
    showModalBottomSheet(
      context: scaffoldKey.currentContext!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder:
          (context) => Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag Handle
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),

                /// Edit Name
                BottomSheetOption(
                  icon: Icons.edit,
                  label: "Edit Name",
                  color: Color(0xff3c75ef),
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: Text("Update Product Name"),
                            content: TextField(
                              controller: nameTC,
                              decoration: InputDecoration(
                                hintText: "Enter New Name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: CupertinoColors.activeBlue,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Cancel"),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await updateName(nameTC.text, id);
                                  nameTC.clear();
                                  Navigator.pop(context);
                                },
                                child: Text("Save"),
                              ),
                            ],
                          ),
                    );
                  },
                ),

                Divider(thickness: 1, color: Colors.black12),
                BottomSheetOption(
                  icon: Icons.image_outlined,
                  label: "Edit Image",
                  color: Color(0xff3c75ef),
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: Text("Update Product Image"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Cancel"),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await pickImage();
                                  await deleteImage(imageUrl);
                                  await updateImage(id);
                                  Navigator.pop(context);
                                },
                                child: Text("Update"),
                              ),
                            ],
                          ),
                    );
                  },
                ),
                Divider(thickness: 1, color: Colors.black12),
                BottomSheetOption(
                  icon: CupertinoIcons.delete,
                  label: "Delete",
                  color: Color(0xffdc3a3a),
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder:
                          (context) => DeleteDialog(
                            onTap: () => deleteItem(id, context),
                          ),
                    );
                  },
                ),
              ],
            ),
          ),
    );
  }

  Future<void> updateName(String name, int id) async {
    try {
      await service
          .from('products')
          .update({'name': name})
          .eq('id', id)
          .select()
          .single();
      productName = name;
      isUpdatedName = true;
      notifyListeners();
    } catch (e) {
      print('Error Updating Name $e');
    }
  }

  Future<void> deleteItem(int id, BuildContext context) async {
    try {
      await service.from('transactions').delete().eq('product_id', id);
      await service.from('products').delete().eq('id', id);
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DashboardScreen()),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Item Deleted")));
    } catch (e) {
      print("Error Deleting Item $e");
    }
  }

  Future<void> readTransactions(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await service.from('transactions').select('*');
      transactionList = response;
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
      print("Error Fetching List $e");
      transactionList = [];
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteImage(String imageURL) async {
    try {
      final uri = Uri.parse(imageURL);
      final segments = uri.pathSegments;
      final bucketPathIndex = segments.indexOf('object') + 2;
      if (bucketPathIndex < 2 || bucketPathIndex >= segments.length) {
        throw Exception("Invalid image URL format.");
      }

      final filePath = segments.sublist(bucketPathIndex).join('/');
      await service.storage.from('image').remove(['uploads/$filePath']);
      print("Old Image Deleted Successfully");
    } catch (e) {
      print("Error Deleting Image from Bucket: $e");
    }
  }

  Future<void> updateImage(int id) async {
    try {
      await service
          .from('products')
          .update({'image_url': publicUrl})
          .eq('id', id)
          .select()
          .single();
      isUpdatedImage = true;
      notifyListeners();
    } catch (e) {
      print("Error Updating Image: $e");
    }
  }

  Future pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image,
      );
      if (result != null && result.files.single.path != null) {
        image = result.files.single.bytes!;
        fileName = result.files.single.name;
        notifyListeners();
        await uploadImage(image, fileName);
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
      await service.storage
          .from('images')
          .uploadBinary(
            'uploads/$fileName',
            image!,
            fileOptions: FileOptions(contentType: mimeType),
          );
      publicUrl = service.storage
          .from('images')
          .getPublicUrl('uploads/$fileName');
      notifyListeners();
      print('✅ Upload successful: $publicUrl');
    } catch (e) {
      print('Upload failed: $e');
    }
  }
}
