import 'package:flutter/material.dart';
import 'package:rikedu/src/features/school_management/models/teacher.dart';

class TeacherList extends StatelessWidget {
  final List<Teacher> teachers;

  const TeacherList(this.teachers, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: teachers.length,
      itemBuilder: (ctx, index) => Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(teachers[index].imageUrl),
          ),
          title: Text(teachers[index].name),
          subtitle: Text('Email: ${teachers[index].email}'),
        ),
      ),
    );
  }
}
