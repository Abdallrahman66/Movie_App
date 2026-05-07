import 'package:hive/hive.dart';
part 'watch_list_entity.g.dart';

@HiveType(typeId: 0)
class WatchListEntity extends HiveObject {
  WatchListEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.voteAverage,
    required this.publishDate,
    required this.category,
    required this.timeOfMovie,
    required this.description,
  });

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final double voteAverage;

  @HiveField(4)
  final String publishDate;

  @HiveField(5)
  final String category;

  @HiveField(6)
  final String timeOfMovie;

  @HiveField(7)
  final String description;


}
