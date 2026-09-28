import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/sound_service.dart';
import '../widgets/duo_button.dart';
import 'fast_reflex_screen.dart';
import 'flashcards_screen.dart';

class SplashMascotScreen extends StatefulWidget {
  const SplashMascotScreen({super.key});

  static void show(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: true,
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (context, anim, secAnim) => const SplashMascotScreen(),
        transitionsBuilder: (context, animation, secAnim, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  State<SplashMascotScreen> createState() => _SplashMascotScreenState();
}

class _SplashMascotScreenState extends State<SplashMascotScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  final List<String> _parrotTips = [
    "TYT Taktik: Paragraf sorularında önce soru kökünü oku, sonra şıkları tara! 🎯",
    "Garipçiler (I. Yeni): Orhan Veli, Melih Cevdet, Oktay Rifat -> OMO! 💡",
    "Fotosentez formülü: 6CO2 + 6H2O -> C6H12O6 + 6O2! 🌿",
    "Sağ El Kuralı: Başparmak akım, dört parmak alan, avuç içi kuvvet! ⚡",
    "İkinci Yeni şifresi: ECE SÜTÇÜ! 📜",
    "Her gün çözülen 20 paragraf ve 20 problem seni zirveye taşır! 🏆",
  ];

  late String _currentQuote;

  @override
  void initState() {
    super.initState();
    _currentQuote = _parrotTips[Random().nextInt(_parrotTips.length)];

    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: -8.0, end: 8.0).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      SoundService.playCorrect();
    });
  }

  void _onParrotTap() {
    HapticFeedback.mediumImpact();
    SoundService.playFlip();
    setState(() {
      _currentQuote = _parrotTips[Random().nextInt(_parrotTips.length)];
    });
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF8B5CF6),
              Color(0xFF0F172A),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close_rounded, color: Colors.white, size: 28),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Text(
                      'YKS Quest Maskotu 🦜✨',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _onParrotTap,
                child: AnimatedBuilder(
                  animation: _bounceAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _bounceAnimation.value),
                      child: child,
                    );
                  },
                  child: Container(
                    width: size.width * 0.55,
                    height: size.width * 0.55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF8B5CF6).withOpacity(0.5),
                          blurRadius: 36,
                          spreadRadius: 8,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/mascot.png',
                      errorBuilder: (_, __, _err) => const Center(
                        child: Text('🦜', style: TextStyle(fontSize: 100)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Text(
                    _currentQuote,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF1E293B),
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: DuoButton(
                  text: 'HIZLI REFLEKS OYNA ⚡',
                  color: DuoButtonColor.green,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const FastReflexScreen()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: DuoButton(
                  text: 'FLAŞ KARTLARI ÇALIŞ 🎴',
                  color: DuoButtonColor.purple,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const FlashcardsScreen()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
