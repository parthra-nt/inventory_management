import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mime/mime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:untitled/auth/auth_service.dart';

class AddItemProvider extends ChangeNotifier {
  Uint8List? image;
  String? fileName;
  String publicUrl = '';

  final TextEditingController name = TextEditingController();
  final TextEditingController quantity = TextEditingController();

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
      publicUrl = AuthService().supabase.storage
          .from('images')
          .getPublicUrl('uploads/$fileName');
      notifyListeners();
      print('✅ Upload successful: $publicUrl');
    } catch (e) {
      print('Upload failed: $e');
    }
  }

  Future<void> addItemTable() async {
    try {
      final parsedQuantity = int.parse(quantity.text.trim());
      final productResponse =
          await AuthService().supabase
              .from('products')
              .insert({
                'name': name.text.trim(),
                'quantity': parsedQuantity,
                'image_url': publicUrl,
              })
              .select('id')
              .single();
      name.clear();
      quantity.clear();
      image = null;
      fileName = null;
      final String productId = productResponse['id'];
      await AuthService().supabase.from('transactions').insert({
        'product_id': productId,
        'quantity': parsedQuantity,
        'type': 'in',
      });
      clearUrl();
      print("Data Added Successfully into Products");
    } catch (e) {
      print("Error Inserting Data into Products Table $e");
    }
  }

  void clearUrl() {
    publicUrl = '';
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    name.dispose();
    quantity.dispose();
    clearUrl();
    super.dispose();
  }
}
