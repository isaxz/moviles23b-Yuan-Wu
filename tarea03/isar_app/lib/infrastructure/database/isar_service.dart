import 'package:isar/isar.dart';
import 'package:isar_app/domain/schemas.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if(Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [ProfessorSchema, CourseSchema], 
        directory: dir.path
      );
    }
    return await Future.value(Isar.getInstance());
  }

  Future<void> addProfessor(Professor professor) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.professors.put(professor);
    });
  }

  Future<List<Professor>> getProfessors() async {
    final isar = await db;
    return await isar.professors.where().findAll();
  }

  Future<Professor?> getProfessor(int id) async {
    final isar = await db;
    return await isar.professors.get(id);
  }

  void deleteProfessor(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.professors.delete(id);
    });
  }
  
  void addCourse(Course course) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.courses.put(course);
      await course.professor.save();
    });
  }

  Future<List<Course>> getCourses() async {
    final isar = await db;
    return await isar.courses.where().findAll();
  }
}