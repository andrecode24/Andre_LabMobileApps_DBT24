import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'product_details.dart' as pd;

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const WastellaApp());
}

// ─── Data Models ────────────────────────────────────────────────────────────

class Product {
  final String name;
  final String price;
  final String category;
  final String imageUrl;
  final Color? cardColor;

  const Product({
    required this.name,
    required this.price,
    required this.category,
    required this.imageUrl,
    this.cardColor,
  });
}

class Category {
  final String label;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;

  const Category({
    required this.label,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
  });
}

// ─── Mock Data ───────────────────────────────────────────────────────────────

final List<Product> bannerProducts = [
  const Product(
    name: 'Biodegradable Food Wrap',
    price: 'Rp49.000',
    category: 'Sustainable Living',
    imageUrl: 'https://images.unsplash.com/photo-1610348725531-843dff563e2c?w=400',
  ),
  const Product(
    name: 'Composting Planting Bags',
    price: 'Rp69.000',
    category: 'Sustainable Living',
    imageUrl: 'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=400',
  ),
  const Product(
    name: 'Bamboo Utensil Set',
    price: 'Rp55.000',
    category: 'Eco Friendly Home',
    imageUrl: 'https://images.unsplash.com/photo-1584464491033-06628f3a6b7b?w=400',
  ),
];

final List<Category> categories = [
  Category(
    label: 'Eco Friendly\nFashion',
    icon: Icons.checkroom_rounded,
    bgColor: const Color(0xFFE8E4F8),
    iconColor: const Color(0xFF7C6BC4),
  ),
  Category(
    label: 'Eco Friendly\nHome',
    icon: Icons.cottage_rounded,
    bgColor: const Color(0xFFE4F0E8),
    iconColor: const Color(0xFF4A9B6F),
  ),
  Category(
    label: 'Green Tech &\nGadgets',
    icon: Icons.eco_rounded,
    bgColor: const Color(0xFFDFF2E8),
    iconColor: const Color(0xFF2D8653),
  ),
  Category(
    label: 'Sustainable\nLiving',
    icon: Icons.spa_rounded,
    bgColor: const Color(0xFFFFF3E0),
    iconColor: const Color(0xFFE07B39),
  ),
];

final List<Product> featuredProducts = [
  const Product(
    name: 'Biodegradable Yoga Mat',
    price: 'Rp. 50.000',
    category: 'Sustainable Living',
    imageUrl: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=400',
    cardColor: Color(0xFFFFB5C8),
  ),
  const Product(
    name: 'Compostable Face Masks',
    price: 'Rp. 20.000',
    category: 'Sustainable Living',
    imageUrl: 'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=400',
    cardColor: Color(0xFFF5E6D3),
  ),
  const Product(
    name: 'Water Purifier Beads',
    price: 'Rp. 20.000',
    category: 'Green Tech & Gadgets',
    imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400',
    cardColor: Color(0xFFFFD580),
  ),
  const Product(
    name: 'Rice Husk Coffee Cup',
    price: 'Rp. 20.000',
    category: 'Eco Friendly Home',
    imageUrl: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400',
    cardColor: Color(0xFF2C2C2C),
  ),
  const Product(
    name: 'Plantable Pens',
    price: 'Rp. 20.000',
    category: 'Eco Friendly Home',
    imageUrl: 'https://images.unsplash.com/photo-1455390582262-044cdead277a?w=400',
    cardColor: Color(0xFFFFF3C4),
  ),
  const Product(
    name: 'Organic T-Shirts',
    price: 'Rp. 20.000',
    category: 'Eco-Friendly Fashion',
    imageUrl: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400',
    cardColor: Color(0xFFE8DDD0),
  ),
];

// ─── App ─────────────────────────────────────────────────────────────────────

class WastellaApp extends StatelessWidget {
  const WastellaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wastella EcoMarket',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2D8653),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// ─── Home Screen ─────────────────────────────────────────────────────────────

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: CustomScrollView(
        slivers: [
          // ── Hero Header ──
          SliverToBoxAdapter(child: _HeroHeader()),

          // ── Banner Products ──
          SliverToBoxAdapter(child: _BannerSection()),

          // ── Categories ──
          SliverToBoxAdapter(child: _CategoriesSection()),

          // ── Featured Products ──
          SliverToBoxAdapter(child: _FeaturedSection()),

          const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
        ],
      ),
      bottomNavigationBar: _BottomNav(),
    );
  }
}

// ─── Hero Header ─────────────────────────────────────────────────────────────

class _HeroHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0xFF1B4332),
              ),
            ),
          ),
          // Gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.65),
                  ],
                ),
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search bar
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.92),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Find your product',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[400],
                        ),
                        suffixIcon: const Icon(Icons.search_rounded, color: Color(0xFF2D8653)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Title row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Wastella\nEcoMarket',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Sustainable Shopping for a Greener Future',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Action icons
                      Row(
                        children: [
                          _HeaderIcon(icon: Icons.storefront_rounded),
                          const SizedBox(width: 10),
                          _HeaderIcon(icon: Icons.receipt_long_rounded),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  final IconData icon;
  const _HeaderIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.4)),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}

// ─── Banner Section ───────────────────────────────────────────────────────────

class _BannerSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: bannerProducts.length,
          itemBuilder: (context, index) {
            return _BannerCard(product: bannerProducts[index]);
          },
        ),
      ),
    );
  }
}

class _BannerCard extends StatelessWidget {
  final Product product;
  const _BannerCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          final int priceVal = int.tryParse(
                  product.price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 20000;
          final pd.Product pdProduct = pd.Product(
            name: product.name,
            description: product.name,
            price: product.price,
            category: product.category,
            imageUrl: product.imageUrl,
            rating: 4.5,
            productPrice: priceVal,
            tax: (priceVal * 0.1).round(),
            shippingFee: 3000,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => pd.ProductDetailScreen(product: pdProduct),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Product image
              Positioned.fill(
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: const Color(0xFFE0E0E0)),
                ),
              ),
              // Bottom gradient + info
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.75),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.price,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        product.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        product.category,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 9,
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
  }
}

// ─── Categories Section ───────────────────────────────────────────────────────

class _CategoriesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        height: 90,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return _CategoryChip(category: categories[index]);
          },
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final Category category;
  const _CategoryChip({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: category.bgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(category.icon, color: category.iconColor, size: 26),
          ),
          const SizedBox(height: 6),
          Text(
            category.label,
            style: TextStyle(
              fontSize: 9,
              color: Colors.grey[600],
              height: 1.2,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ─── Featured Section ─────────────────────────────────────────────────────────

class _FeaturedSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured Sustainable Products',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.82,
            ),
            itemCount: featuredProducts.length,
            itemBuilder: (context, index) {
              return _ProductCard(product: featuredProducts[index]);
            },
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final bool isDark = product.cardColor != null &&
        product.cardColor!.computeLuminance() < 0.2;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image area
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: product.cardColor ?? const Color(0xFFEEEEEE),
                  ),
                  Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const SizedBox(),
                  ),
                ],
              ),
            ),
          ),
          // Info area
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1A1A),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  product.price,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2D8653),
                  ),
                ),
                Text(
                  product.category,
                  style: TextStyle(
                    fontSize: 9,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Bottom Nav ───────────────────────────────────────────────────────────────

class _BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NavItem(icon: Icons.home_rounded, label: 'Home', active: true),
              _NavItem(icon: Icons.explore_rounded, label: 'Explore'),
              _NavItem(icon: Icons.shopping_bag_rounded, label: 'Cart'),
              _NavItem(icon: Icons.person_rounded, label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  const _NavItem({required this.icon, required this.label, this.active = false});

  @override
  Widget build(BuildContext context) {
    final color = active ? const Color(0xFF2D8653) : Colors.grey[400]!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: color,
            fontWeight: active ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}