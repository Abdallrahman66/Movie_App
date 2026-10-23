import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_section/app_section_view.dart';
import '../../../core/utils/app_colors.dart';
import '../data/onboarding_data.dart';
import 'widgets/onboarding_button.dart';
import 'widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const String routeName = '/onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;

  int _currentPage = 0;
  bool _isFinishing = false;

  bool get _isLastPage => _currentPage == OnboardingPages.items.length - 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    if (_isFinishing) return;

    setState(() => _isFinishing = true);

    try {
      final preferences = await SharedPreferences.getInstance();

      await preferences.setBool('onboarding_completed', true);

      if (!mounted) return;

      Navigator.of(context).pushReplacementNamed(AppSectionView.routeName);
    } catch (e) {
      if (!mounted) return;

      setState(() => _isFinishing = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong. Please try again.'),
        ),
      );
    }
  }

  Future<void> _continue() async {
    if (_isLastPage) {
      await _finishOnboarding();
      return;
    }

    await _pageController.nextPage(
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOutCubic,
    );
  }

  Future<void> _skip() async {
    await _finishOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth < 380 ? 20.0 : 24.0;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSkipButton(),

                  const SizedBox(height: 16),

                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: OnboardingPages.items.length,
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: OnboardingPage(
                            data: OnboardingPages.items[index],
                            index: index,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  _buildPageIndicator(),

                  const SizedBox(height: 24),

                  OnboardingButton(
                    label: _isLastPage ? 'Get Started' : 'Continue',
                    onPressed: _isFinishing ? () {} : _continue,
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: _isFinishing ? null : _skip,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          minimumSize: const Size(40, 32),
          foregroundColor: AppColor.secondaryTextLightColor,
        ),
        child: const Text(
          'Skip',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(OnboardingPages.items.length, (index) {
        final isSelected = index == _currentPage;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.only(right: 8),
          width: isSelected ? 32 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isSelected
                ? AppColor.primaryColor
                : AppColor.indicatorInactiveColor,
            borderRadius: BorderRadius.circular(20),
          ),
        );
      }),
    );
  }
}
