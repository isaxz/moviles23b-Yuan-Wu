import 'package:isar/isar.dart';
import 'package:isar_app/domain/schemas/course.dart';

part 'professor.g.dart';

@collection
class Professor {
  Id? id = Isar.autoIncrement;

  String? firstName;
  String? lastName;

  @Backlink(to: 'professor')
  final courses = IsarLinks<Course>();

}