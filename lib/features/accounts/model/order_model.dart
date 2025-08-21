class OrderModel {
  final String orderId;
  final DateTime date;
  final String status;
  final double totalAmount;
  final int itemCount;

  OrderModel({
    required this.orderId,
    required this.date,
    required this.status,
    required this.totalAmount,
    required this.itemCount,
  });
}
