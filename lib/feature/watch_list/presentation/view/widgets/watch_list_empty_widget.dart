import 'package:flutter/material.dart';

class WatchListEmptyWidget extends StatelessWidget {
  const WatchListEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
          _buildImage(),
          const SizedBox(height: 24),
          const Text(
            "There Is No Movie Yet!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Find your movie by Type title,\ncategories, years, etc",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    try {
      return Image.asset(
        'assets/images/magic-box.png',
        width: 200,
        height: 200,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          print('Error loading image: $error');
          return Column(
            children: [
              Icon(
                Icons.local_movies_outlined,
                size: 80,
                color: Colors.grey[600],
              ),
              const SizedBox(height: 8),
              Text(
                'Image not found',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Exception: $e');
      return Icon(
        Icons.local_movies_outlined,
        size: 80,
        color: Colors.grey[600],
      );
    }
  }
}
