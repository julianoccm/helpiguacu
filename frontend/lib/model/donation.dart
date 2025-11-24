import 'package:frontend/model/status_donation.dart';

import 'donation_item.dart';

class Donation {
  final int? id;
  final String title;
  final String description;
  final StatusDonation status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<DonationItem> items;
  final int? donorId;

  Donation({
    this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
    required this.donorId
  });

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      id: json['id'],
      title: json['title'],
      donorId: json['donorId'],
      description: json['description'],
      status: StatusDonation.fromString(json['status']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      items: (json['items'] as List<dynamic>)
          .map((e) => DonationItem.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'donorId': donorId,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'items': items.map((i) => i.toJson()).toList(),
    };
  }
}
