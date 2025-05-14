import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/presentation/screens/items_details_screen.dart';
import 'package:untitled/providers/item_page_provider.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.quantity,
    required this.id,
  });

  final String imageUrl;
  final String id;
  final String name;
  final String quantity;

  @override
  Widget build(BuildContext context) {
    var q = int.parse(quantity);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => ChangeNotifierProvider(
                  create: (_) => ItemPageProvider(q),
                  child: ItemDetailsScreen(
                    imageUrl: imageUrl,
                    productName: name,
                    quantity: quantity,
                    id: id,
                  ),
                ),
          ),
        );
      },
      child: Container(
        height: 100,
        width: 360,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 0.5),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              height: 50,
              width: 50,
              color: Colors.black,
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
            Expanded(
              child: Text(
                name,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                quantity,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.cyan,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
