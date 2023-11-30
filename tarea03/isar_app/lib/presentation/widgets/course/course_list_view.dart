import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_app/presentation/blocs.dart';
import 'package:isar_app/presentation/widgets.dart';

class CourseListView extends StatefulWidget {
  const CourseListView({super.key});

  @override
  State<CourseListView> createState() => _CourseListViewState();
}

class _CourseListViewState extends State<CourseListView> {

  @override
  void initState() {
    super.initState();
    context.read<CourseCubit>().getCourses();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final courses = context.watch<CourseCubit>().state.courses;
    return Column(
      children: [
        const SizedBox(height: 15,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Text('Lista de cursos',
                style: TextStyle(
                  fontSize: 22,
                  color: colors.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15,),
        Expanded(
          child: ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return CustomeCard(
                title: '${courses[index].code} '
                  '${courses[index].name}',
                elevation: 2,
                onPressedDelete: () {},
                onPressedEdit: () {},
                onPressedView: () {},
              );
            },
          ),
        ),
        const SizedBox(height: 15,),
        FilledButton.icon(
          onPressed: (){
            context.push('/add-course')
            .then((value) => Future.delayed(
              const Duration(milliseconds: 250),
              () => context.read<CourseCubit>().getCourses()
            ));
          }, 
          icon: const Icon(Icons.add), 
          label: const Text('Agregar curso')
        ),
        const SizedBox(height: 15,),
      ],
    );
  }
}