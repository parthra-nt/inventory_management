import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Do You really want to delete this Item ? Also The Transaction History will be Deleted",
        style: TextStyle(color: Colors.red),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        ElevatedButton(onPressed: onTap, child: Text("Delete")),
      ],
    );
  }
}
