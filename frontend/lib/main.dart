import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/colors.dart';
import 'package:frontend/routes/app_routes.dart';

final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

void main() {
  runApp(const NutricanApp());
}

class NutricanApp extends StatelessWidget {
  const NutricanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nutrican App',
      theme: ThemeData(
        primaryColor: NutricanColors.primary,
        appBarTheme: AppBarTheme(
          backgroundColor: NutricanColors.primary,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary:NutricanColors.primary,
        ),
      ),
      initialRoute: kIsWeb ? AppRoutes.login: AppRoutes.onboarding,
      routes: AppRoutes.routes,
      navigatorObservers: [routeObserver]
    );
  }
}