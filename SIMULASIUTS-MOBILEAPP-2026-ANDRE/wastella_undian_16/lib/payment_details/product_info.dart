import 'package:flutter/material.dart';
import 'confirmation.dart';

// ─── Models ───────────────────────────────────────────────────────────────────

class ShippingAddress {
  final String name;
  final String phone;
  final String street;
  final String city;
  final String postalCode;
  final String province;

  const ShippingAddress({
    required this.name,
    required this.phone,
    required this.street,
    required this.city,
    required this.postalCode,
    required this.province,
  });

  String get fullAddress => '$street, $city, $postalCode, $province, Indonesia';

  ShippingAddress copyWith({
    String? name,
    String? phone,
    String? street,
    String? city,
    String? postalCode,
    String? province,
  }) {
    return ShippingAddress(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      street: street ?? this.street,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      province: province ?? this.province,
    );
  }
}

class ShippingOption {
  final String courier;
  final String logoAsset;
  final String label;
  final int price;
  final String eta;
  final bool recommended;

  const ShippingOption({
    required this.courier,
    required this.logoAsset,
    required this.label,
    required this.price,
    required this.eta,
    this.recommended = false,
  });
}

// ─── Currency formatter ───────────────────────────────────────────────────────

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

// ─── Product Info Screen ──────────────────────────────────────────────────────

class ProductInfoScreen extends StatefulWidget {
  final String productName;
  final String productImageUrl;
  final int productPrice;

  const ProductInfoScreen({
    super.key,
    required this.productName,
    required this.productImageUrl,
    required this.productPrice,
  });

  @override
  State<ProductInfoScreen> createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  ShippingAddress _address = const ShippingAddress(
    name: 'Aiden Green',
    phone: '+62 812-3456-7890',
    street: 'Jl. Merdeka No. 45, Kebayoran Baru',
    city: 'Jakarta Selatan',
    postalCode: '12160',
    province: 'DKI Jakarta',
  );

  int _selectedShipping = 0;
  int _selectedPayment = -1;
  final _messageController = TextEditingController();

  final List<ShippingOption> _shippingOptions = const [
    ShippingOption(
      courier: 'JNE',
      logoAsset: 'JNE',
      label: 'Fast Delivery',
      price: 5000,
      eta: 'Get it by Tomorrow, 20 Feb 25',
      recommended: true,
    ),
    ShippingOption(
      courier: 'DHL',
      logoAsset: 'DHL',
      label: 'Free Delivery',
      price: 0,
      eta: 'Get it by Saturday, 22 Feb 25',
    ),
  ];

  final List<Map<String, String>> _paymentMethods = const [
    {'name': 'BCA Virtual Account', 'logo': 'BCA'},
    {'name': 'Mandiri Virtual Account', 'logo': 'MANDIRI'},
    {'name': 'BRI Virtual Account', 'logo': 'BRI'},
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _openEditAddress() async {
    final result = await Navigator.of(context).push<ShippingAddress>(
      MaterialPageRoute(
        builder: (_) => ShippingAddressScreen(address: _address),
      ),
    );
    if (result != null) {
      setState(() => _address = result);
    }
  }

  int get _shippingCost =>
      _selectedShipping < _shippingOptions.length
          ? _shippingOptions[_selectedShipping].price
          : 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // ── Green Header ──
          _GreenHeader(),

          // ── Scrollable Content ──
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle('Product Information & Review'),
                  const SizedBox(height: 12),
                  _ProductInfoCard(
                    name: widget.productName,
                    imageUrl: widget.productImageUrl,
                    price: widget.productPrice,
                  ),
                  const SizedBox(height: 20),

                  // ── Address ──
                  _AddressCard(
                    address: _address,
                    onEdit: _openEditAddress,
                  ),
                  const SizedBox(height: 20),

                  _sectionTitle('Delivery Shipping'),
                  const SizedBox(height: 12),
                  _ShippingSelector(
                    options: _shippingOptions,
                    selected: _selectedShipping,
                    onSelect: (i) => setState(() => _selectedShipping = i),
                  ),
                  const SizedBox(height: 20),

                  _sectionTitle('Payment Method'),
                  const SizedBox(height: 12),
                  _PaymentSelector(
                    methods: _paymentMethods,
                    selected: _selectedPayment,
                    onSelect: (i) => setState(() => _selectedPayment = i),
                  ),
                  const SizedBox(height: 20),

                  _sectionTitle('Your Message'),
                  const SizedBox(height: 12),
                  _MessageField(controller: _messageController),
                ],
              ),
            ),
          ),
        ],
      ),

      // ── Place Order Button ──
      bottomNavigationBar: _PlaceOrderBar(onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PaymentConfirmationScreen(
              totalAmount: widget.productPrice,
            ),
          ),
        );
      }),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Color(0xFF1A1A1A),
      ),
    );
  }
}

// ─── Green Header ─────────────────────────────────────────────────────────────

class _GreenHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        bottom: 20,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2D8653), Color(0xFF1A5C38)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ── Back button top-left ──
          Positioned(
            left: 8,
            top: 0,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          // ── Centred icon + title ──
          Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/logo.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.eco_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Make a Difference Today',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Product Info Card ────────────────────────────────────────────────────────

class _ProductInfoCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final int price;

  const _ProductInfoCard({
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
            child: AspectRatio(
              aspectRatio: 16 / 7,
              child: imageUrl.startsWith('assets/')
                ? Image.asset(imageUrl, fit: BoxFit.cover)
                : Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFFE8F5E9),
                      child: const Icon(Icons.eco_rounded,
                          size: 40, color: Color(0xFF2D8653)),
                    ),
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + Price row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 1,
                      height: 36,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      formatRupiah(price),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Tags
                Wrap(
                  spacing: 8,
                  children: ['Small', 'Leaf Green', 'Beeswax Wrap']
                      .map(
                        (t) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            t,
                            style: const TextStyle(
                                fontSize: 11, color: Color(0xFF555555)),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Address Card ─────────────────────────────────────────────────────────────

class _AddressCard extends StatelessWidget {
  final ShippingAddress address;
  final VoidCallback onEdit;

  const _AddressCard({required this.address, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      address.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      address.phone,
                      style: TextStyle(
                          fontSize: 13, color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  address.fullAddress,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onEdit,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF2D8653)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Edit',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D8653),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Shipping Selector ────────────────────────────────────────────────────────

class _ShippingSelector extends StatelessWidget {
  final List<ShippingOption> options;
  final int selected;
  final ValueChanged<int> onSelect;

  const _ShippingSelector({
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: List.generate(options.length, (i) {
          final opt = options[i];
          final isSelected = selected == i;
          final isLast = i == options.length - 1;
          return GestureDetector(
            onTap: () => onSelect(i),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                border: isLast
                    ? null
                    : Border(
                        bottom: BorderSide(color: Colors.grey.shade100)),
              ),
              child: Row(
                children: [
                  // Courier logo placeholder
                  _CourierLogo(name: opt.courier),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 8,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              opt.price == 0
                                  ? 'Free Delivery'
                                  : '${formatRupiah(opt.price)} - ${opt.label}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1A1A1A),
                              ),
                            ),
                            if (opt.recommended)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F5E9),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  'Recommend',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF2D8653),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          opt.eta,
                          style: TextStyle(
                              fontSize: 11, color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                  Radio<int>(
                    value: i,
                    groupValue: selected,
                    onChanged: (v) => onSelect(v!),
                    activeColor: const Color(0xFF2D8653),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _CourierLogo extends StatelessWidget {
  final String name;
  const _CourierLogo({required this.name});

  String get _assetPath {
    switch (name.toUpperCase()) {
      case 'JNE':
        return 'assets/JNE.png';
      case 'DHL':
        return 'assets/DHL.png';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final path = _assetPath;
    return SizedBox(
      width: 44,
      height: 28,
      child: path.isNotEmpty
          ? Image.asset(
              path,
              fit: BoxFit.contain,
              width: 44,
              height: 28,
            )
          : const SizedBox(),
    );
  }
}

// ─── Payment Selector ─────────────────────────────────────────────────────────

class _PaymentSelector extends StatelessWidget {
  final List<Map<String, String>> methods;
  final int selected;
  final ValueChanged<int> onSelect;

  const _PaymentSelector({
    required this.methods,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: List.generate(methods.length, (i) {
          final method = methods[i];
          final isLast = i == methods.length - 1;
          return GestureDetector(
            onTap: () => onSelect(i),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                border: isLast
                    ? null
                    : Border(
                        bottom: BorderSide(color: Colors.grey.shade100)),
              ),
              child: Row(
                children: [
                  _BankLogo(name: method['logo']!),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      method['name']!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ),
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected == i
                            ? const Color(0xFF2D8653)
                            : Colors.grey.shade400,
                        width: 2,
                      ),
                    ),
                    child: selected == i
                        ? const Center(
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor: Color(0xFF2D8653),
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _BankLogo extends StatelessWidget {
  final String name;
  const _BankLogo({required this.name});

  String get _assetPath {
    switch (name.toUpperCase()) {
      case 'BCA':
        return 'assets/BCA.png';
      case 'BRI':
        return 'assets/BRI.png';
      case 'MANDIRI':
        return 'assets/mandiri.png';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final path = _assetPath;
    return SizedBox(
      width: 44,
      height: 28,
      child: path.isNotEmpty
          ? Image.asset(
              path,
              fit: BoxFit.contain,
              width: 44,
              height: 28,
            )
          : const SizedBox(),
    );
  }
}

// ─── Message Field ────────────────────────────────────────────────────────────

class _MessageField extends StatelessWidget {
  final TextEditingController controller;
  const _MessageField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: 'Ex: Take it easy',
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}

// ─── Place Order Bar ──────────────────────────────────────────────────────────

class _PlaceOrderBar extends StatelessWidget {
  final VoidCallback onTap;
  const _PlaceOrderBar({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          24, 12, 24, MediaQuery.of(context).padding.bottom + 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 52,
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
            'Place Order',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Shipping Address Edit Screen ─────────────────────────────────────────────

class ShippingAddressScreen extends StatefulWidget {
  final ShippingAddress address;
  const ShippingAddressScreen({super.key, required this.address});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  late TextEditingController _nameCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _streetCtrl;
  late TextEditingController _cityCtrl;
  late TextEditingController _postalCtrl;
  late TextEditingController _provinceCtrl;

  @override
  void initState() {
    super.initState();
    final a = widget.address;
    _nameCtrl = TextEditingController(text: a.name);
    _phoneCtrl = TextEditingController(text: a.phone);
    _streetCtrl = TextEditingController(text: a.street);
    _cityCtrl = TextEditingController(text: a.city);
    _postalCtrl = TextEditingController(text: a.postalCode);
    _provinceCtrl = TextEditingController(text: a.province);
  }

  @override
  void dispose() {
    for (final c in [
      _nameCtrl, _phoneCtrl, _streetCtrl,
      _cityCtrl, _postalCtrl, _provinceCtrl
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void _save() {
    final updated = ShippingAddress(
      name: _nameCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      street: _streetCtrl.text.trim(),
      city: _cityCtrl.text.trim(),
      postalCode: _postalCtrl.text.trim(),
      province: _provinceCtrl.text.trim(),
    );
    Navigator.of(context).pop(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 20, color: Color(0xFF1A1A1A)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Shipping Address',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              child: Column(
                children: [
                  _AddressField(
                      controller: _nameCtrl,
                      hint: 'Recipient Name',
                      maxLines: 1),
                  const SizedBox(height: 14),
                  _AddressField(
                      controller: _phoneCtrl,
                      hint: 'Phone Number',
                      maxLines: 1,
                      keyboardType: TextInputType.phone),
                  const SizedBox(height: 14),
                  _AddressField(
                      controller: _streetCtrl,
                      hint: 'Street Address',
                      maxLines: 3),
                  const SizedBox(height: 14),
                  _AddressField(
                      controller: _cityCtrl,
                      hint: 'City/District',
                      maxLines: 1),
                  const SizedBox(height: 14),
                  _AddressField(
                      controller: _postalCtrl,
                      hint: 'Postal Code',
                      maxLines: 1,
                      keyboardType: TextInputType.number),
                  const SizedBox(height: 14),
                  _AddressField(
                      controller: _provinceCtrl,
                      hint: 'Province/State',
                      maxLines: 1),
                ],
              ),
            ),
          ),

          // Save Address Button
          Padding(
            padding: EdgeInsets.fromLTRB(
                20, 0, 20, MediaQuery.of(context).padding.bottom + 20),
            child: GestureDetector(
              onTap: _save,
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: const Color(0xFF2D8653),
                    width: 2,
                  ),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Save Address',
                  style: TextStyle(
                    color: Color(0xFF2D8653),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddressField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final TextInputType keyboardType;

  const _AddressField({
    required this.controller,
    required this.hint,
    required this.maxLines,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A1A)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        ),
      ),
    );
  }
}

// ─── Preview ──────────────────────────────────────────────────────────────────

void main() {
  runApp(const _PreviewApp());
}

class _PreviewApp extends StatelessWidget {
  const _PreviewApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductInfoScreen(
        productName: 'Biodegradable Food Wrap',
        productImageUrl:
            'https://images.unsplash.com/photo-1610348725531-843dff563e2c?w=600',
        productPrice: 49000,
      ),
    );
  }
}