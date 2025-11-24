class DonationItem {
  final int? id;
  final String name;
  final int quantity;

  DonationItem({
    this.id,
    required this.name,
    required this.quantity,
  });

  factory DonationItem.fromJson(Map<String, dynamic> json) {
    return DonationItem(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
    };
  }
}
