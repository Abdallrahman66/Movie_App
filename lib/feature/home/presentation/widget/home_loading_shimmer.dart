import 'package:flutter/material.dart';
import 'package:movie_app/core/widgets/loading_shimmer.widget.dart';

class HomeLoadingShimmer extends StatelessWidget {
  const HomeLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _section(),
          _list(),
          _section(),
          _list(),
          _section(),
          _list(),
        ],
      ),
    );
  }

  Widget _section() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: LoadingShimmer(
          width: 140,
          height: 20,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  Widget _list() {
    return SizedBox(
      height: 260,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: LoadingShimmer(
              width: 160,
              height: 240,
              borderRadius: BorderRadius.circular(12),
            ),
          );
        },
      ),
    );
  }
}
