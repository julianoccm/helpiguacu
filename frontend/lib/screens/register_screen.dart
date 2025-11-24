import 'package:flutter/material.dart';
import 'package:frontend/components/primary_button.dart';
import 'package:frontend/components/text_input.dart';
import 'package:frontend/constants/colors.dart';
import 'package:frontend/model/user.dart';
import 'package:frontend/routes/app_routes.dart';
import 'package:frontend/service/authentication_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerCpf = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerAdressCep = TextEditingController();
  final TextEditingController _controllerAdressNumber = TextEditingController();
  final TextEditingController _controllerAdressComplement = TextEditingController();

  @override
  Widget build(BuildContext context) {

    void showErrorDialog() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Registro inválido'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Text(
            "Erro ao autenticar, verifique os dados informados e tente novamente.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }

    void register() {
      AuthenticationService.register(
        User(
            id: null,
            name: _controllerName.text,
            cpf: _controllerCpf.text,
            email: _controllerEmail.text,
            password: _controllerPassword.text,
            cep: _controllerAdressCep.text,
            addresNumber: _controllerAdressNumber.text,
            addresComplement: _controllerAdressComplement.text,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now()
        )
      )
      .then((_) {
        Navigator.pushNamed(context, AppRoutes.login);
      })
      .catchError((error) {
        showErrorDialog();
        return;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 600;
          final double cardWidth = isMobile ? constraints.maxWidth * 0.9 : 400;

          return SingleChildScrollView(
            child: Container(
              width: constraints.maxWidth,

              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [NutricanColors.secundary, NutricanColors.primary],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 100),
                      Container(
                        width: cardWidth,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 40,
                            horizontal: 20,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Registro",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Já tem uma conta?",
                                    style: TextStyle(
                                      color: NutricanColors.font,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, AppRoutes.login);
                                    },
                                    child: Text(
                                      "  Acesse",
                                      style: TextStyle(
                                        color: NutricanColors.primaryButton,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              TextInput(
                                controller: _controllerName,
                                placeholder: "Nome",
                                label: "Nome",
                                inputType: InputType.text,
                              ),
                              const SizedBox(height: 20),
                              TextInput(
                                controller: _controllerCpf,
                                placeholder: "CPF",
                                label: "CPF",
                                inputType: InputType.cpf,
                              ),
                              const SizedBox(height: 20),
                              TextInput(
                                controller: _controllerEmail,
                                placeholder: "Email",
                                label: "Email",
                                inputType: InputType.email,
                              ),
                              const SizedBox(height: 20),
                              TextInput(
                                controller: _controllerPassword,
                                placeholder: "Senha",
                                label: "Senha",
                                inputType: InputType.password,
                              ),
                              const SizedBox(height: 20),
                              TextInput(
                                controller: _controllerAdressCep,
                                placeholder: "CEP",
                                label: "CEP",
                                inputType: InputType.cep,
                              ),
                              const SizedBox(height: 20),
                              TextInput(
                                controller: _controllerAdressNumber,
                                placeholder: "Numero da rua",
                                label: "Numero da rua"
                              ),
                              const SizedBox(height: 20),
                              TextInput(
                                  controller: _controllerAdressComplement,
                                  placeholder: "Complemento",
                                  label: "Complemento"
                              ),
                              const SizedBox(height: 40),
                              FractionallySizedBox(
                                widthFactor: 1.0,
                                child: PrimaryButton(
                                  onPressed: register,
                                  child: const Text(
                                    "Registrar",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.center,
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
        },
      ),
    );
  }
}
