class StockCountModel {
  final String title;
  final DateTime date;
  final int total;
  final int stockIn;
  final int stockOut;

  StockCountModel({
    required this.title,
    required this.date,
    required this.total,
    required this.stockIn,
    required this.stockOut,
  });
}
