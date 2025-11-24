import 'package:flutter/material.dart';
import 'package:frontend/components/primary_button.dart';
import 'package:frontend/components/text_input.dart';
import 'package:frontend/constants/colors.dart';
import 'package:frontend/model/auth_representation.dart';
import 'package:frontend/routes/app_routes.dart';
import 'package:frontend/service/authentication_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {

    void showErrorDialog() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login inválido'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Text(
            "Erro ao autenticar, verifique o usuário e senha e tente novamente.",
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

    void login() {
      AuthenticationService.authenticate(
        AuthRepresentation(
          username: _controllerEmail.text,
          password: _controllerPassword.text,
        ),
      )
      .then((_) {
        Navigator.pushNamed(context, AppRoutes.donations);
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
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [NutricanColors.secundary, NutricanColors.primary],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                              "Login",
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
                                  "Não tem uma conta?",
                                  style: TextStyle(
                                    color: NutricanColors.font,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, AppRoutes.register);
                                  },
                                  child: Text(
                                    "  Registre-se",
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
                            const SizedBox(height: 40),
                            FractionallySizedBox(
                              widthFactor: 1.0,
                              child: PrimaryButton(
                                onPressed: login,
                                child: const Text(
                                  "Acessar",
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
          );
        },
      ),
    );
  }
}
