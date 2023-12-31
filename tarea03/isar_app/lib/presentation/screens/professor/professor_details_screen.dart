import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar_app/domain/schemas.dart';
import 'package:isar_app/presentation/blocs.dart';

class ProfessorDetailsScreen extends StatelessWidget {
  final int id;

  const ProfessorDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfessorCubit(),
        ),
        BlocProvider(
          create: (context) => CourseCubit(),
        ),
      ],
      child: _ProfessorDetailsView(
        id: id,
      ),
    );
  }
}

class _ProfessorDetailsView extends StatefulWidget {
  final int id;

  const _ProfessorDetailsView({required this.id});

  @override
  State<_ProfessorDetailsView> createState() => _ProfessorDetailsViewState();
}

class _ProfessorDetailsViewState extends State<_ProfessorDetailsView> {
  @override
  void initState() {
    super.initState();
    context.read<ProfessorCubit>().getProfessor(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final String firstName = context.watch<ProfessorCubit>().state.firstName;
    final String lastName = context.watch<ProfessorCubit>().state.lastName;
    final List<Course> courses = context.watch<ProfessorCubit>().state.courses;

    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('$firstName $lastName'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(
                  'Lista de cursos (${courses.length})',
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
              itemBuilder: (context, index) => ListTile(
                leading: const Icon(Icons.calendar_today_rounded),
                title: Text('${courses[index].name}'),
                subtitle: Text('${courses[index].code}'),
              )
            ),
          ),
        ],
      ),
    );
  }
}
