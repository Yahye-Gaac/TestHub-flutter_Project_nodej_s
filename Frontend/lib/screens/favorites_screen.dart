import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../models/product.dart';
import '../state/cart_model.dart';
import '../state/favorites_model.dart';
import '../state/products_model.dart';
import '../widgets/simple_topbar.dart';
import '../widgets/white_panel.dart';
import 'product_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final CartModel cart;
  final FavoritesModel fav;
  final ProductsModel products;

  const FavoritesScreen({super.key, required this.cart, required this.fav, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            const SimpleTopBar(title: 'Favorite'),
            Expanded(
              child: WhitePanel(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                child: AnimatedBuilder(
                  animation: Listenable.merge([fav, products]),
                  builder: (_, __) {
                    final all = products.items;
                    final items = all.where((p) => fav.isFav(p.id)).toList();

                    if (products.loading && all.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (items.isEmpty) {
                      return const Center(
                        child: Text('No favorites yet', style: TextStyle(color: AppColors.textMute, fontWeight: FontWeight.w700)),
                      );
                    }

                    return ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, i) => _FavRow(
                        p: items[i],
                        onOpen: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: items[i], cart: cart, fav: fav)),
                        ),
                        onAdd: () => cart.add(items[i]),
                        onRemove: () => fav.toggle(items[i].id),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavRow extends StatelessWidget {
  final Product p;
  final VoidCallback onOpen;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const _FavRow({required this.p, required this.onOpen, required this.onAdd, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onOpen,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(color: AppColors.field, borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                p.imageUrl,
                height: 58,
                width: 58,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 58,
                  width: 58,
                  color: const Color(0xFFE0DCD3),
                  child: const Icon(Icons.image_not_supported),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.name, style: const TextStyle(fontWeight: FontWeight.w900), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Text(p.subtitle.isEmpty ? p.category : p.subtitle,
                      style: const TextStyle(color: AppColors.textMute, fontWeight: FontWeight.w700, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Text('\$${p.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            IconButton(onPressed: onRemove, icon: const Icon(Icons.favorite_rounded, color: AppColors.orange)),
            IconButton(onPressed: onAdd, icon: const Icon(Icons.shopping_cart_rounded, color: AppColors.brown)),
          ],
        ),
      ),
    );
  }
}
