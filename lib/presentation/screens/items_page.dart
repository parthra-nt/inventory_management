import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/presentation/screens/add_item_screen.dart';
import 'package:untitled/presentation/widgets/items_widget.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddItemScreen()),
          );
        },
        backgroundColor: CupertinoColors.systemBlue,
        child: Icon(
          CupertinoIcons.plus,
          color: Colors.white,
          size: 30,
          weight: 50,
        ),
      ),
      backgroundColor: Colors.grey.shade50,
      body: Center(
        child: SizedBox(
          width: 380,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListView.builder(
                  itemCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ItemsWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
