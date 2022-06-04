class History{
  final String? userId;
  final String? name;
  final double? total;
  final DateTime? date;
  final String? description;
  final String? orderId;

  History({
    this.userId, this.name, this.total, this.date, this.description, this.orderId});
}

List<History> demoHistory = [
  History(userId: '',
  name: 'Thanh toán',
  total: 100000,
  date: DateTime.now(),
  description: 'Thanh toán thành công',
  orderId: '')
];