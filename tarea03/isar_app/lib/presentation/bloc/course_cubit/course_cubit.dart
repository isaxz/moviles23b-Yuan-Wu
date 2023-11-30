import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:isar_app/domain/schemas.dart';
import 'package:isar_app/infrastructure/database/isar_service.dart';

part 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  final isarService = IsarService();

  CourseCubit() : super(const CourseState());

  Future<void> addCourse(Course course) async {
    isarService.addCourse(course);
  }

  Future<void> getCourses() async {
    List<Course> courses = await isarService.getCourses();
    emit(
      state.copyWith(
        courses: courses,
      )
    );
  }
}
