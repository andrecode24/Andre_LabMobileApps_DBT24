import 'package:flutter/material.dart';
import 'splashscreen.dart';
import 'package:flutter/services.dart';
import 'dart:async';

// ─── Payment Confirmation Screen ──────────────────────────────────────────────

class PaymentConfirmationScreen extends StatefulWidget {
  final int totalAmount;
  final String paymentMethod;

  const PaymentConfirmationScreen({
    super.key,
    required this.totalAmount,
    this.paymentMethod = 'BCA Virtual Account',
  });

  @override
  State<PaymentConfirmationScreen> createState() =>
      _PaymentConfirmationScreenState();
}

class _PaymentConfirmationScreenState extends State<PaymentConfirmationScreen> {
  // Countdown timer — 23 hours 50 minutes 50 seconds
  late int _remainingSeconds;
  Timer? _timer;
  bool _copied = false;

  static const String _virtualAccount = '192 0851 3624 9696';
  static const String _dueDate = '25 March 2025, 04.00PM';

  // Accordion state
  final Map<String, bool> _expanded = {
    'mBanking': false,
    'iBanking': false,
    'ATM': false,
  };

  @override
  void initState() {
    super.initState();
    _remainingSeconds = (23 * 3600) + (50 * 60) + 50;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedTime {
    final h = _remainingSeconds ~/ 3600;
    final m = (_remainingSeconds % 3600) ~/ 60;
    final s = _remainingSeconds % 60;
    return '${h.toString().padLeft(2, '0')} Hours '
        '${m.toString().padLeft(2, '0')} Minute '
        '${s.toString().padLeft(2, '0')} Seconds';
  }

  String formatRupiah(int amount) {
    final str = amount.toString();
    final buffer = StringBuffer();
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) buffer.write('.');
      buffer.write(str[i]);
      count++;
    }
    return 'Rp ${buffer.toString().split('').reversed.join()}';
  }

  void _copyVA() async {
    await Clipboard.setData(
        ClipboardData(text: _virtualAccount.replaceAll(' ', '')));
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  void _toggleSection(String key) {
    setState(() => _expanded[key] = !(_expanded[key] ?? false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 20, color: Color(0xFF1A1A1A)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Payment Confirmation',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A1A1A),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              child: Column(
                children: [
                  // ── Virtual Account Card ──
                  _VACard(
                    virtualAccount: _virtualAccount,
                    formattedTime: _formattedTime,
                    total: formatRupiah(widget.totalAmount),
                    dueDate: _dueDate,
                    copied: _copied,
                    onCopy: _copyVA,
                  ),

                  const SizedBox(height: 24),

                  // ── Transfer Guides ──
                  _TransferGuideAccordion(
                    title: 'mBanking Transfer Guide',
                    icon: Icons.smartphone_rounded,
                    expanded: _expanded['mBanking']!,
                    onTap: () => _toggleSection('mBanking'),
                    steps: const [
                      'Open your bank\'s mobile banking app and log in.',
                      'Tap "Transfer" then select "Virtual Account".',
                      'Enter the Virtual Account number shown above.',
                      'Confirm the merchant name: Wastella EcoMarket.',
                      'Check the payment amount and tap "Confirm".',
                      'Enter your mPIN or OTP to complete the transfer.',
                      'Save the transaction receipt for your records.',
                    ],
                  ),

                  const SizedBox(height: 12),

                  _TransferGuideAccordion(
                    title: 'iBanking Transfer Guide',
                    icon: Icons.computer_rounded,
                    expanded: _expanded['iBanking']!,
                    onTap: () => _toggleSection('iBanking'),
                    steps: const [
                      'Visit your bank\'s internet banking website and log in.',
                      'Navigate to "Transfer" → "Virtual Account Payment".',
                      'Enter the Virtual Account number shown above.',
                      'Verify the destination: Wastella EcoMarket.',
                      'Confirm the total amount matches your order.',
                      'Enter your token/OTP code to authorise the payment.',
                      'Download or screenshot the confirmation page.',
                    ],
                  ),

                  const SizedBox(height: 12),

                  _TransferGuideAccordion(
                    title: 'ATM Transfer Guide',
                    icon: Icons.credit_card_rounded,
                    expanded: _expanded['ATM']!,
                    onTap: () => _toggleSection('ATM'),
                    steps: const [
                      'Insert your ATM card and enter your PIN.',
                      'Select "Other Transactions" → "Payment".',
                      'Choose "Virtual Account" from the payment options.',
                      'Key in the Virtual Account number shown above.',
                      'The screen will display the payee and amount — verify them.',
                      'Press "Yes" or "Confirm" to proceed with the payment.',
                      'Collect your receipt from the ATM as proof of payment.',
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ── Check Status Button ──
          _CheckStatusBar(onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const PurchaseSplashScreen()),
          );
        }),
        ],
      ),
    );
  }
}

// ─── Virtual Account Card ─────────────────────────────────────────────────────

class _VACard extends StatelessWidget {
  final String virtualAccount;
  final String formattedTime;
  final String total;
  final String dueDate;
  final bool copied;
  final VoidCallback onCopy;

  const _VACard({
    required this.virtualAccount,
    required this.formattedTime,
    required this.total,
    required this.dueDate,
    required this.copied,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Label
          const Text(
            'Virtual Account Number',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF555555),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),

          // VA Number + Copy
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                virtualAccount,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2D8653),
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: onCopy,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    copied
                        ? Icons.check_circle_rounded
                        : Icons.copy_rounded,
                    key: ValueKey(copied),
                    size: 22,
                    color: copied
                        ? const Color(0xFF2D8653)
                        : const Color(0xFF5B8DB8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Countdown
          Text(
            formattedTime,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[400],
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 20),
          const Divider(color: Color(0xFFF0F0F0)),
          const SizedBox(height: 16),

          // Total row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              Text(
                total,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Due date row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Due Date',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              Text(
                dueDate,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Transfer Guide Accordion ─────────────────────────────────────────────────

class _TransferGuideAccordion extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool expanded;
  final VoidCallback onTap;
  final List<String> steps;

  const _TransferGuideAccordion({
    required this.title,
    required this.icon,
    required this.expanded,
    required this.onTap,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Header row ──
          GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 24,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Expanded Steps ──
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(color: Color(0xFFF0F0F0)),
                  const SizedBox(height: 12),
                  ...steps.asMap().entries.map((entry) {
                    final i = entry.key + 1;
                    final step = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Step number bubble
                          Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Color(0xFF2D8653),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '$i',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              step,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Check Status Bar ─────────────────────────────────────────────────────────

class _CheckStatusBar extends StatelessWidget {
  final VoidCallback onTap;
  const _CheckStatusBar({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          24, 12, 24, MediaQuery.of(context).padding.bottom + 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1A3D52), Color(0xFF2D8653)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(32),
          ),
          alignment: Alignment.center,
          child: const Text(
            'Check Status',
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

// ─── Preview ──────────────────────────────────────────────────────────────────

void main() {
  runApp(const _PreviewApp());
}

class _PreviewApp extends StatelessWidget {
  const _PreviewApp();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaymentConfirmationScreen(
        totalAmount: 49000,
        paymentMethod: 'BCA Virtual Account',
      ),
    );
  }
}