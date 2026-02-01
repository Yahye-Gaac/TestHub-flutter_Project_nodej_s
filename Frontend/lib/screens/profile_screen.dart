import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/routes.dart';
import '../state/cart_model.dart';
import '../state/favorites_model.dart';
import '../state/session_store.dart';
import '../widgets/white_panel.dart';
import '../widgets/buttons.dart';

class ProfileScreen extends StatelessWidget {
  final CartModel cart;
  final FavoritesModel fav;
  final SessionStore session;

  const ProfileScreen({
    super.key,
    required this.cart,
    required this.fav,
    required this.session,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: session,
      builder: (_, __) {
        final email = session.email ?? 'Not signed in';
        final name = (session.username != null && session.username!.trim().isNotEmpty)
            ? session.username!.trim()
            : 'TasteHub User';

        return Scaffold(
          backgroundColor: AppColors.bg,
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.brown.withOpacity(0.15),
                        child: const Icon(Icons.person_rounded, color: AppColors.brown),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            email,
                            style: const TextStyle(
                              color: AppColors.textMute,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.edit_rounded)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: WhitePanel(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                    child: Column(
                      children: [
                        _MenuItem(icon: Icons.favorite_border_rounded, text: 'Favorite List', onTap: () {}),
                        _MenuItem(icon: Icons.shopping_cart_outlined, text: 'Cart', onTap: () {}),
                        _MenuItem(icon: Icons.help_outline_rounded, text: 'Help', onTap: () {}),
                        const Spacer(),
                        OutlineButtonX(
                          text: 'Logout',
                          onTap: () {
                            cart.clear();
                            fav.clear();
                            session.clear();
                            Navigator.pushNamedAndRemoveUntil(context, Routes.getStarted, (_) => false);
                          },
                        ),
                      ],
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

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _MenuItem({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.field,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.brown),
            const SizedBox(width: 12),
            Text(text, style: const TextStyle(fontWeight: FontWeight.w900)),
            const Spacer(),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textMute),
          ],
        ),
      ),
    );
  }
}
