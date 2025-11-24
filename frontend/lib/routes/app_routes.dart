import 'package:flutter/material.dart';
import 'package:frontend/screens/donation_register_screen.dart';
import 'package:frontend/screens/donations_details_screen.dart';
import 'package:frontend/screens/donations_screen.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/onboarding_screen.dart';
import 'package:frontend/screens/register_screen.dart';

class AppRoutes {
  static const onboarding = "/onboarding";
  static const login = "/login";
  static const register = "/register";
  static const donations = "/donations";
  static const registerDonation = "/registerDonation";
  static const donationDetails = "/donationDetails";


  static Map<String, WidgetBuilder> routes = {
    onboarding: (context) => OnboardingScreen(),
    login: (context) => LoginScreen(),
    donations: (context) => DonationsScreen(),
    register: (context) => RegisterScreen(),
    registerDonation: (context) => DonationRegisterScreen(),
    donationDetails: (context) => DonationDetailsScreen()
  };
}