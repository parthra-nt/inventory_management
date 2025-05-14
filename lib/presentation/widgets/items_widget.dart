import 'package:flutter/material.dart';
import 'package:untitled/presentation/screens/item_details_screen.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ItemDetailsScreen()),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              height: 50,
              width: 50,
              color: Colors.black,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Name of Product",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                RichText(
                  text: TextSpan(
                    text: "SKU:",
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: "Product SKU",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "Cost:",
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: "Product Cost",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "Price:",
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: "Product Price",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 80),
              child: Text(
                "80",
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
