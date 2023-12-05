part of 'course_cubit.dart';

class CourseState extends Equatable {

  final List<Course> courses;
  //Datos de un curso
  final int id;
  final String code;
  final String name;
  final String professorFirstName;
  final String professorLastName;

  const CourseState({
    this.courses = const [],
    this.id = -1,
    this.code = '',
    this.name = '',
    this.professorFirstName = '',
    this.professorLastName = '',
  });

  CourseState copyWith({
    List<Course>? courses,
    int? id,
    String? code,
    String? name,
    String? professorFirstName,
    String? professorLastName,
  }) => CourseState(
    courses: courses ?? this.courses,
    id: id ?? this.id,
    code: code ?? this.code,
    name: name ?? this.name,
    professorFirstName: professorFirstName ?? this.professorFirstName,
    professorLastName: professorLastName ?? this.professorLastName,
  );

  @override
  List<Object> get props => [courses, id, code, name, professorFirstName, professorLastName];
}
