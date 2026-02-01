import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/routes.dart';
import '../widgets/buttons.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 510,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.brown,
                borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(200, 80)),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 18,
                    top: 12,
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
                        children: [
                          const TextSpan(text: 'Taste', style: TextStyle(color: Colors.white)),
                          TextSpan(text: 'Hub', style: TextStyle(color: AppColors.orange)),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Image.asset(
                        'assets/images/waiter.png',
                        height: 560,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                padding: const EdgeInsets.fromLTRB(22, 18, 22, 18),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    const Text(
                      'Tasty food\ndelivered fast!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Order your favorite meals and drinks with a clean, fast experience. '
                      'Discover top restaurants, explore delicious menus, and enjoy quick delivery right to your door.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.textMute, fontWeight: FontWeight.w600, height: 1.4),
                    ),
                    const Spacer(),
                    PrimaryButton(
                      text: 'Get Started Now',
                      onTap: () => Navigator.pushReplacementNamed(context, Routes.auth),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
