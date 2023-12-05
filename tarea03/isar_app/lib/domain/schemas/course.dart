import 'package:isar/isar.dart';
import 'package:isar_app/domain/schemas/professor.dart';
import 'package:isar_app/domain/schemas/student.dart';

part 'course.g.dart';

@collection
class Course {
  Id? id = Isar.autoIncrement;

  @Index(unique: true)
  String? code;

  String? name;

  final professor = IsarLink<Professor>();

  @Backlink(to: 'courses')
  final students = IsarLinks<Student>();
}