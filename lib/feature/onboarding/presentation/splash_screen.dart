import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/app_colors.dart';
import '../../onboarding/presentation/onboarding_screen.dart';
import '../../../app_section/app_section_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _iconFade;
  late final Animation<Offset> _iconSlide;

  late final Animation<double> _logoFade;
  late final Animation<Offset> _logoSlide;

  late final Animation<double> _loaderFade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );

    _iconFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.40, curve: Curves.easeOut),
    );

    _iconSlide = Tween<Offset>(begin: const Offset(0, 0.18), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.45, curve: Curves.easeOutCubic),
          ),
        );

    _logoFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.30, 0.75, curve: Curves.easeOut),
    );

    _logoSlide = Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.30, 0.78, curve: Curves.easeOutCubic),
          ),
        );

    _loaderFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.65, 0.95, curve: Curves.easeIn),
    );

    _startSplash();
  }

  Future<void> _startSplash() async {
    await _controller.forward();

    await Future<void>.delayed(const Duration(milliseconds: 350));

    final preferences = await SharedPreferences.getInstance();

    if (!mounted) return;

    final onboardingCompleted =
        preferences.getBool('onboarding_completed') ?? false;

    Navigator.of(context).pushReplacementNamed(
      onboardingCompleted
          ? AppSectionView.routeName
          : OnboardingScreen.routeName,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              FadeTransition(
                opacity: _iconFade,
                child: SlideTransition(
                  position: _iconSlide,
                  child: Image.asset(
                    'assets/images/filmo_icon.png',
                    width: 112,
                    height: 112,
                    fit: BoxFit.contain,
                    
                  ),
                ),
              ),

              const SizedBox(height: 24),

              FadeTransition(
                opacity: _logoFade,
                child: SlideTransition(
                  position: _logoSlide,
                  child: Image.asset(
                    'assets/images/filmo_logo_text.png',
                    width: 280,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        height: 60,
                        child: Center(
                          child: Text(
                            'Filmo logo image not found',
                            style: TextStyle(
                              color: AppColor.primaryTextColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 28),

              FadeTransition(
                opacity: _loaderFade,
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: AppColor.primaryColor,
                    backgroundColor: AppColor.primaryColor.withValues(
                      alpha: 0.15,
                    ),
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
