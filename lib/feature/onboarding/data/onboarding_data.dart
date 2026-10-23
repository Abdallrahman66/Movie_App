class OnboardingData {
  const OnboardingData({
    required this.image,
    required this.title,
    required this.highlightedTitle,
    required this.description,
  });

  final String image;
  final String title;
  final String highlightedTitle;
  final String description;
}

abstract final class OnboardingPages {
  static const List<OnboardingData> items = [
    OnboardingData(
      image: 'assets/images/discover.png',
      title: 'Discover cinema,',
      highlightedTitle: 'beautifully.',
      description:
          'Trending, top rated and upcoming films, curated '
          'for discerning viewers.',
    ),
    OnboardingData(
      image: 'assets/images/reels.png',
      title: 'Swipe through',
      highlightedTitle: 'Reels.',
      description:
          'Watch short vertical trailers and find your next '
          'favorite in seconds.',
    ),
    OnboardingData(
      image: 'assets/images/watchlist.png',
      title: 'Build your',
      highlightedTitle: 'Watch list.',
      description:
          'Save every movie you love, curate midnight '
          'retrospectives, and never lose track again.',
    ),
  ];
}
