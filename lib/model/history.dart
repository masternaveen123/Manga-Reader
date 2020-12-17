import 'package:hive/hive.dart';

part 'history.g.dart';

@HiveType(typeId: 0)
class History {
  @HiveField(0)
  String currentTitle;
  @HiveField(1)
  String thumbnail;
  @HiveField(2)
  int source;
  @HiveField(3)
  String currentChapter;
  @HiveField(4)
  String currentPage;
  @HiveField(5)
  String sourceSpecificName;
  @HiveField(6)
  DateTime currentTime = DateTime.now();

  History(
    this.currentTitle,
    this.thumbnail,
    this.source,
    this.currentChapter,
    this.currentPage,
    this.sourceSpecificName,
  );
}
