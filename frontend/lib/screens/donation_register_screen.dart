import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/gradient_button.dart';
import 'package:frontend/components/header.dart';
import 'package:frontend/components/text_input.dart';
import 'package:frontend/components/title.dart';
import 'package:frontend/constants/colors.dart';
import 'package:frontend/model/donation.dart';
import 'package:frontend/model/donation_item.dart';
import 'package:frontend/model/status_donation.dart';
import 'package:frontend/service/donation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';

class DonationRegisterScreen extends StatefulWidget {
  const DonationRegisterScreen({super.key});

  @override
  State<DonationRegisterScreen> createState() => _DonationRegisterScreenState();
}

class _DonationRegisterScreenState extends State<DonationRegisterScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<DonationItem> items = [];
  final List<TextEditingController> itemNameControllers = [];
  final List<TextEditingController> itemQuantityControllers = [];

  void addItem() {
    setState(() {
      items.add(DonationItem(name: "", quantity: 1));

      itemNameControllers.add(TextEditingController());
      itemQuantityControllers.add(TextEditingController(text: "1"));
    });
  }

  void removeItem(int index) {
    setState(() {
      items.removeAt(index);
      itemNameControllers.removeAt(index);
      itemQuantityControllers.removeAt(index);
    });
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Erro"),
        content: Text(message),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  Future<void> saveDonation() async {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        items.isEmpty) {
      showErrorDialog("Preencha título, descrição e adicione pelo menos 1 item.");
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = jsonDecode(prefs.getString('user')!);
    final donorId = user["id"];

    List<DonationItem> finalItems = [];
    for (int i = 0; i < items.length; i++) {
      final String name = itemNameControllers[i].text;
      final int qty = int.tryParse(itemQuantityControllers[i].text) ?? 1;

      if (name.isEmpty) {
        showErrorDialog("O item ${i + 1} está sem nome.");
        return;
      }

      finalItems.add(DonationItem(name: name, quantity: qty));
    }

    Donation donation = Donation(
      id: null,
      title: _titleController.text,
      description: _descriptionController.text,
      status: StatusDonation.PENDENTE_COLETA,
      items: finalItems,
      donorId: donorId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now()
    );

    try {
      await DonationService.createDonation(donation);

      Navigator.pushNamed(context, AppRoutes.donations);
    } catch (e) {
      showErrorDialog("Erro ao salvar a doação. Tente novamente.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
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
                PageTitle(text: "Cadastrar Doação"),
                const SizedBox(height: 20),

                Card(
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextInput(
                          controller: _titleController,
                          label: "Título da Doação",
                          placeholder: "",
                        ),
                        const SizedBox(height: 15),

                        TextInput(
                          controller: _descriptionController,
                          label: "Descrição",
                          placeholder: "",
                        ),

                        const SizedBox(height: 30),
                        Divider(),
                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Itens da doação",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: addItem,
                              icon: Icon(Icons.add),
                              label: Text("Adicionar item"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: NutricanColors.primary,
                                foregroundColor: Colors.white,
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: 15),

                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: EdgeInsets.only(bottom: 12),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    TextInput(
                                      controller: itemNameControllers[index],
                                      label: "Nome do item",
                                      placeholder: "",
                                    ),
                                    const SizedBox(height: 10),
                                    TextInput(
                                      controller: itemQuantityControllers[index],
                                      label: "Quantidade",
                                      placeholder: "",
                                      inputType: InputType.text,
                                    ),
                                    const SizedBox(height: 10),

                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton.icon(
                                        onPressed: () => removeItem(index),
                                        icon: Icon(Icons.delete, color: Colors.red),
                                        label: Text("Remover", style: TextStyle(color: Colors.red)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        FractionallySizedBox(
                          widthFactor: 1,
                          child: GradientButton(
                            onPressed: saveDonation,
                            child: const Text(
                              textAlign: TextAlign.center,
                              "Salvar",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
