import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class HomeTopAnimation extends StatefulWidget {
  const HomeTopAnimation({super.key});

  @override
  State<HomeTopAnimation> createState() => _HomeTopAnimationState();
}

class _HomeTopAnimationState extends State<HomeTopAnimation>
    with SingleTickerProviderStateMixin {
  static const Color _gold = Color(0xFFC9A96E);

  static const List<String> _messages = [
    'YOUR NEXT FAVORITE',
    'TONIGHT IS FOR CINEMA',
    'A WORLD OF STORIES',
  ];

  late final AnimationController _controller;
  Timer? _timer;

  int _index = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;

      setState(() {
        _index = (_index + 1) % _messages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 84,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final phase = _controller.value * 2 * math.pi;
              final pulse = math.sin(phase);

              return Transform.scale(
                scale: 1 + pulse * 0.035,
                child: SizedBox(
                  width: 36,
                  height: 36,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: _gold.withOpacity(0.8)),
                          boxShadow: [
                            BoxShadow(
                              color: _gold.withOpacity(
                                0.12 + (pulse + 1) * 0.04,
                              ),
                              blurRadius: 12 + (pulse + 1) * 3,
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.play_arrow_rounded,
                        color: _gold,
                        size: 24,
                      ),
                      Positioned.fill(
                        child: Transform.rotate(
                          angle: phase,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: const BoxDecoration(
                                color: _gold,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 4),

          SizedBox(
            height: 20,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) {
                final slide = Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(animation);

                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(position: slide, child: child),
                );
              },
              child: Text(
                _messages[_index],
                key: ValueKey(_index),
                maxLines: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.3,
                ),
              ),
            ),
          ),

          const SizedBox(height: 3),

          const Text(
            'DISCOVER  •  WATCH  •  REPEAT',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF85858D),
              fontSize: 8,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.8,
            ),
          ),
        ],
      ),
    );
  }
}
