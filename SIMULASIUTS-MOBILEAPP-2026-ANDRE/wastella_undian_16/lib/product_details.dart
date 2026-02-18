import 'package:flutter/material.dart';
import 'payment_details/product_info.dart';

// ─── Product Model (shared, ideally move to models/product.dart) ─────────────

class Product {
  final String name;
  final String description;
  final String price;
  final String category;
  final String imageUrl;
  final double rating;
  final int productPrice;
  final int tax;
  final int shippingFee;

  const Product({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    this.rating = 4.5,
    required this.productPrice,
    required this.tax,
    required this.shippingFee,
  });

  int get totalPayment => productPrice + tax + shippingFee;
}

// ─── Currency Formatter (no Intl package needed) ─────────────────────────────

String formatRupiah(int amount) {
  final str = amount.toString();
  final buffer = StringBuffer();
  int count = 0;
  for (int i = str.length - 1; i >= 0; i--) {
    if (count > 0 && count % 3 == 0) buffer.write('.');
    buffer.write(str[i]);
    count++;
  }
  return 'Rp${buffer.toString().split('').reversed.join()}';
}

// ─── Sample Review Model ──────────────────────────────────────────────────────

class Review {
  final String author;
  final String avatarUrl;
  final double rating;
  final String body;
  final String timeAgo;

  const Review({
    required this.author,
    required this.avatarUrl,
    required this.rating,
    required this.body,
    required this.timeAgo,
  });
}

// ─── Product Detail Screen ────────────────────────────────────────────────────

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _sheetController;
  late Animation<double> _sheetAnimation;
  bool _sheetExpanded = false;

  static const double _collapsedSheetHeight = 68.0;
  static const double _expandedSheetHeight = 320.0;

  final List<Review> _reviews = const [
    Review(
      author: 'Hadri',
      avatarUrl: 'https://i.pravatar.cc/150?img=11',
      rating: 5,
      body:
          'Effectively keeps food fresh and reduces plastic waste, making it a highly recommended, sustainable alternative to traditional plastic wrap',
      timeAgo: '7d ago',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _sheetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    _sheetAnimation = CurvedAnimation(
      parent: _sheetController,
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  void _toggleSheet() {
    setState(() => _sheetExpanded = !_sheetExpanded);
    if (_sheetExpanded) {
      _sheetController.forward();
    } else {
      _sheetController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ── Main scrollable content ──
          CustomScrollView(
            slivers: [
              // AppBar
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                pinned: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      size: 20, color: Color(0xFF1A1A1A)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: const Text(
                  'Product Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                centerTitle: true,
              ),

              SliverToBoxAdapter(
                child: Padding(
                  // extra bottom padding so content doesn't hide behind sheet
                  padding: EdgeInsets.only(
                      bottom: _collapsedSheetHeight + 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ── Product Image ──
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: AspectRatio(
                            aspectRatio: 4 / 3,
                            child: p.imageUrl.startsWith('assets/')
                                ? Image.asset(p.imageUrl, fit: BoxFit.cover)
                                : Image.network(
                                    p.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      color: const Color(0xFFE8F5E9),
                                      child: const Icon(Icons.eco_rounded,
                                          size: 60, color: Color(0xFF2D8653)),
                                    ),
                                  ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ── Product Name ──
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          p.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1A1A1A),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // ── Description ──
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          p.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                            height: 1.6,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ── Attributes Row ──
                      _AttributeRow(rating: p.rating),

                      const SizedBox(height: 28),

                      // ── Review Section ──
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Review',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A1A1A),
                              ),
                            ),
                            const SizedBox(height: 14),
                            ..._reviews
                                .map((r) => _ReviewCard(review: r))
                                .toList(),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ── Animated Price Breakdown Sheet ──
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedBuilder(
              animation: _sheetAnimation,
              builder: (context, child) {
                final height = _collapsedSheetHeight +
                    (_expandedSheetHeight - _collapsedSheetHeight) *
                        _sheetAnimation.value;
                return Container(
                  height: height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(28)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 24,
                        offset: const Offset(0, -6),
                      ),
                    ],
                  ),
                  child: child,
                );
              },
              child: _PriceSheet(
                product: p,
                expanded: _sheetExpanded,
                onTap: _toggleSheet,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Attribute Row ────────────────────────────────────────────────────────────

class _AttributeRow extends StatelessWidget {
  final double rating;
  const _AttributeRow({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _AttributeItem(
              icon: Icons.star_rounded,
              label: '${rating}/5',
            ),
            _AttributeItem(
              icon: Icons.recycling_rounded,
              label: 'Compostable',
            ),
            _AttributeItem(
              icon: Icons.do_not_disturb_alt_rounded,
              label: 'Non Toxic',
            ),
            _AttributeItem(
              icon: Icons.air_rounded,
              label: 'Breathable',
            ),
          ],
        ),
      ),
    );
  }
}

class _AttributeItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _AttributeItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 28, color: const Color(0xFF1A1A1A)),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
      ],
    );
  }
}

// ─── Review Card ──────────────────────────────────────────────────────────────

class _ReviewCard extends StatelessWidget {
  final Review review;
  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(review.avatarUrl),
                backgroundColor: Colors.grey[200],
              ),
              const SizedBox(width: 10),
              Text(
                review.author,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(width: 6),
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    i < review.rating.floor()
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    size: 16,
                    color: const Color(0xFFFFB800),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                review.timeAgo,
                style: TextStyle(fontSize: 11, color: Colors.grey[400]),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            review.body,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF333333),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Price Breakdown Sheet ────────────────────────────────────────────────────

class _PriceSheet extends StatelessWidget {
  final Product product;
  final bool expanded;
  final VoidCallback onTap;

  const _PriceSheet({
    required this.product,
    required this.expanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Pull handle / header ──
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Price breakdown',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A1A1A),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                AnimatedRotation(
                  turns: expanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(Icons.keyboard_arrow_up_rounded,
                      size: 24, color: Color(0xFF1A1A1A)),
                ),
              ],
            ),
          ),
        ),

        // ── Expanded content ──
        if (expanded) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                _PriceRow(
                  label: 'Product price',
                  value: formatRupiah(product.productPrice),
                ),
                const SizedBox(height: 12),
                _PriceRow(
                  label: 'Tax',
                  value: formatRupiah(product.tax),
                ),
                const SizedBox(height: 12),
                _PriceRow(
                  label: 'Shipping fee',
                  value: formatRupiah(product.shippingFee),
                ),
                const SizedBox(height: 16),
                const Divider(height: 1, color: Color(0xFFE0E0E0)),
                const SizedBox(height: 16),
                _PriceRow(
                  label: 'Total Payment',
                  value: formatRupiah(product.totalPayment),
                  bold: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // ── Buy Now Button ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProductInfoScreen(
                      productName: product.name,
                      productImageUrl: product.imageUrl,
                      productPrice: product.productPrice,
                    ),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 54,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2D8653), Color(0xFF1A3D52)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(32),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Buy Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const _PriceRow({
    required this.label,
    required this.value,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: bold ? 15 : 14,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: bold ? 15 : 14,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
            color: const Color(0xFF1A1A1A),
          ),
        ),
      ],
    );
  }
}

// ─── Example usage / preview ─────────────────────────────────────────────────

void main() {
  runApp(const _PreviewApp());
}

class _PreviewApp extends StatelessWidget {
  const _PreviewApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductDetailScreen(
        product: Product(
          name: 'Biodegradable Food Wrap',
          description:
              'Eco-friendly, reusable food wrap made from organic beeswax or plant-based materials. Keeps food fresh naturally!',
          price: 'Rp49.000',
          category: 'Sustainable Living',
          imageUrl:
              'assets/images/foodwrap.jpg',
          rating: 4.5,
          productPrice: 49000,
          tax: 5000,
          shippingFee: 3000,
        ),
      ),
    );
  }
}