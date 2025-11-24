import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/header.dart';
import 'package:frontend/components/title.dart';
import 'package:frontend/constants/colors.dart';
import 'package:frontend/model/donation.dart';
import 'package:frontend/model/donation_item.dart';
import 'package:frontend/service/donation_service.dart';
import 'package:frontend/routes/app_routes.dart';
import 'package:intl/intl.dart';

class DonationDetailsScreen extends StatefulWidget {
  const DonationDetailsScreen({
    super.key,
  });

  @override
  State<DonationDetailsScreen> createState() => _DonationDetailsScreenState();
}

class _DonationDetailsScreenState extends State<DonationDetailsScreen> {
  late int donationId;
  Donation? donation;
  bool loading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    donationId = ModalRoute.of(context)!.settings.arguments as int;
    _loadDonationDetails(donationId);
  }

  Future<void> _loadDonationDetails(int donationId) async {
    final result =
    await DonationService.getDonationById(donationId);

    setState(() {
      donation = result;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
          padding: EdgeInsets.only(
            top: kIsWeb ? 40 : 20,
            bottom: 30,
            left: kIsWeb ? 50 : 20,
            right: kIsWeb ? 50 : 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(goGackPage: AppRoutes.donations),
              const SizedBox(height: 20),
              Text(
                donation!.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Criado em: ${DateFormat('dd/MM/yyyy').format(donation!.createdAt)}",
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 25),
              Text(
                "Status: ${donation?.status.name.replaceAll("_", " ")}",

                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
              Text(
                "Descrição: ${donation?.description}",

                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
              const SizedBox(height: 25),
              const Text(
                "Itens da doação",
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: donation!.items.isEmpty
                    ? const Center(
                  child: Text(
                    "Nenhum item cadastrado ainda.",
                    style: TextStyle(fontSize: 16),
                  ),
                )
                    : ListView.builder(
                  itemCount: donation!.items.length,
                  itemBuilder: (context, index) {
                    final item = donation!.items[index];
                    return _buildItemCard(item);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemCard(DonationItem item) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "${item.name} — ${item.quantity} un.",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
