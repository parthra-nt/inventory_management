import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    super.key,
    required this.date,
    required this.quantity,
    required this.isStockIN,
  });

  final String date;
  final int quantity;
  final String isStockIN;

  String getFormattedDate() {
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat(
        "MMMM dd, yyyy",
      ).format(parsedDate); // e.g., May 20, 2025
    } catch (_) {
      return date; // fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    final isIn = isStockIN.toLowerCase() == 'in';

    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor:
                isIn
                    ? CupertinoColors.activeBlue.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
            child: SvgPicture.asset(
              isIn ? 'assets/images/stockIn.svg' : 'assets/images/stockOut.svg',
              color: isIn ? CupertinoColors.activeBlue : Colors.red,
              height: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isIn ? "Stock IN" : "Stock OUT",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isIn ? CupertinoColors.activeBlue : Colors.red,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  getFormattedDate(),
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
          Text(
            "${isIn ? '+' : '-'}$quantity",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isIn ? CupertinoColors.activeBlue : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
