import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'note_model.g.dart';

@HiveType(typeId: 1)
class NoteModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String category;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String content;

  @HiveField(4)
  final DateTime date;

  NoteModel({
    String? id,
    required this.category,
    required this.title,
    required this.content,
    required this.date,
  }) : id = id ?? const Uuid().v8();
}
