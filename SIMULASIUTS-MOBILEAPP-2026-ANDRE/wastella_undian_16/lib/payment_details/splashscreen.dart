import 'package:flutter/material.dart';

// ─── Splash Screen ────────────────────────────────────────────────────────────

class PurchaseSplashScreen extends StatefulWidget {
  const PurchaseSplashScreen({super.key});

  @override
  State<PurchaseSplashScreen> createState() => _PurchaseSplashScreenState();
}

class _PurchaseSplashScreenState extends State<PurchaseSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _glowController;
  late AnimationController _contentController;

  late Animation<double> _glowAnim;
  late Animation<double> _iconScaleAnim;
  late Animation<double> _cardFadeAnim;
  late Animation<Offset> _cardSlideAnim;
  late Animation<double> _buttonFadeAnim;

  @override
  void initState() {
    super.initState();

    // Pulsing glow behind icon
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _glowAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    // Content entrance animations
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _iconScaleAnim = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
    );

    _cardFadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
      ),
    );

    _cardSlideAnim = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
      ),
    );

    _buttonFadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeOut),
      ),
    );

    // Start entrance after a tiny delay
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _contentController.forward();
    });
  }

  @override
  void dispose() {
    _glowController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _onContinue() {
    // Pop all routes back to the root (HomeScreen)
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // ── Glowing Icon ──
              AnimatedBuilder(
                animation: _glowAnim,
                builder: (context, child) {
                  return Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2D8653)
                              .withOpacity(0.3 * _glowAnim.value),
                          blurRadius: 80 * _glowAnim.value,
                          spreadRadius: 30 * _glowAnim.value,
                        ),
                      ],
                    ),
                    child: child,
                  );
                },
                child: ScaleTransition(
                  scale: _iconScaleAnim,
                  child: Image.asset(
                    'assets/logo.png',
                    width: 180,
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const Spacer(flex: 1),

              // ── Thank You Card ──
              FadeTransition(
                opacity: _cardFadeAnim,
                child: SlideTransition(
                  position: _cardSlideAnim,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 32, horizontal: 28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFF2D8653).withOpacity(0.25),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Thank you for\nYour Purchase!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF2D8653),
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Your order is on its way! Every purchase\nsupports a greener planet.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[600],
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Spacer(flex: 2),

              // ── Continue Button ──
              FadeTransition(
                opacity: _buttonFadeAnim,
                child: GestureDetector(
                  onTap: _onContinue,
                  child: Container(
                    width: double.infinity,
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
                      'Continue',
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

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}



// ─── Preview ──────────────────────────────────────────────────────────────────

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PurchaseSplashScreen(),
  ));
}