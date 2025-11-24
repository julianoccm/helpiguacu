import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/subtitle.dart';
import 'package:frontend/components/title.dart';
import 'package:frontend/constants/colors.dart';
import 'package:frontend/model/donation.dart';
import 'package:frontend/service/donation_service.dart';

import '../main.dart';
import '../routes/app_routes.dart';

class DonationsScreen extends StatefulWidget {
  const DonationsScreen({super.key});

  @override
  State<DonationsScreen> createState() => _DonationsScreenState();
}

class _DonationsScreenState extends State<DonationsScreen> with RouteAware {
  List<Donation> donations = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadDonations();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    _loadDonations();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  Future<void> _loadDonations() async {
    final data = await DonationService.listAllDonations();

    setState(() {
      donations = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top:  kIsWeb ?  40: 20,
                bottom:  30,
                left: kIsWeb ?  50: 25,
                right:  kIsWeb ?  50: 25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const PageTitle(text: "Doações"),
                  const Subtitle(
                    text: "Ver doações cadastradas no sistema",
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: loading
                        ? const Center(child: CircularProgressIndicator())
                        : buildResponsiveGrid(context, donations),
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: 20,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.registerDonation);
                },
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        NutricanColors.lightGreen,
                        NutricanColors.primary,
                      ],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                    ),
                    borderRadius: BorderRadius.circular(200),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(98, 0, 0, 0),
                        blurRadius: 8,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 60),
                ),
              ),
            ),

            Positioned(
              top: 70,
              right: 30,
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    loading = true;
                  });

                  await _loadDonations();
                },
                child: const Icon(Icons.refresh, color: Colors.grey, size: 30),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildResponsiveGrid(
    BuildContext context,
    List<Donation> donations,
  ) {
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount = 1;
    if (width > 1200) {
      crossAxisCount = 4;
    } else if (width > 800) {
      crossAxisCount = 3;
    } else if (width > 600) {
      crossAxisCount = 2;
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 4,
      ),
      itemCount: donations.length,
      itemBuilder: (context, index) {
        final donation = donations[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.donationDetails,
              arguments: donation.id,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [NutricanColors.lightGreen, NutricanColors.primary],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    donation.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
