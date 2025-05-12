import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/presentation/screens/add_item_screen.dart';
import 'package:untitled/presentation/widgets/item_widget.dart';
import 'package:untitled/providers/item_page_provider.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ItemPageProvider>(context, listen: false).readItems();
    });
  }

  @override
  Widget build(BuildContext context) => Consumer<ItemPageProvider>(
    builder:
        (context, provider, child) => Scaffold(
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
              child:
                  provider.isLoading
                      ? CircularProgressIndicator()
                      : provider.itemsList?.isEmpty ?? true
                      ? Text("Not Data")
                      : SingleChildScrollView(
                        child: ListView.builder(
                          itemCount: provider.itemsList?.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder:
                              (context, index) => ItemsWidget(
                                imageUrl:
                                    provider.itemsList![index]['image_url'],
                                quantity:
                                    provider.itemsList![index]['quantity']
                                        .toString(),
                                name: provider.itemsList![index]['name'],
                                id: provider.itemsList![index]['id'],
                              ),
                        ),
                      ),
            ),
          ),
        ),
  );
}
