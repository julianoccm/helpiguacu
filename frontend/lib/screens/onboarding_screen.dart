import 'package:flutter/material.dart';
import 'package:frontend/components/gradient_button.dart';
import 'package:frontend/constants/colors.dart';
import 'package:frontend/constants/onboarding_screen_data.dart';
import 'package:frontend/routes/app_routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * 0.6,
              child: PageView.builder(
                controller: _controller,
                itemCount: onboardingPagesData.length,
                onPageChanged: (index) {
                  setState(
                    () => isLastPage = index == onboardingPagesData.length - 1,
                  );
                },
                itemBuilder: (context, index) {
                  final page = onboardingPagesData[index];

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(page.image, height: 250),
                      SizedBox(height: 20),
                      FractionallySizedBox(
                        widthFactor: 0.75,
                        child: Column(
                          children: [
                            Text(
                              page.title,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Text(
                              page.description,
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            Padding(
              padding: EdgeInsetsGeometry.only(bottom: 25),
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: ExpandingDotsEffect(
                  expansionFactor: 4,
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 8,
                  dotColor: NutricanColors.lightBlue,
                  activeDotColor: NutricanColors.primary,
                ),
              ),
            ),

            FractionallySizedBox(
              widthFactor: 0.70,
              child: GradientButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.login);
                },
                child: Text(
                  "Acessar",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
