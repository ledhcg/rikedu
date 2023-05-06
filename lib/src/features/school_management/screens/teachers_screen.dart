import 'package:flutter/material.dart';
import 'package:rikedu/src/features/school_management/models/teacher.dart';
import 'package:rikedu/src/features/school_management/screens/widgets/teacher_list.dart';

class TeacherScreen extends StatelessWidget {
  static const routeName = '/teachers';

  final List<Teacher> teachers = [
    const Teacher(
      id: 't1',
      name: 'John Smith',
      email: 'Mathematics',
      imageUrl:
          'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
    ),
    const Teacher(
      id: 't2',
      name: 'Jane Doe',
      email: 'Science',
      imageUrl:
          'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
    ),
    const Teacher(
      id: 't3',
      name: 'Bob Johnson',
      email: 'English',
      imageUrl:
          'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
    ),
  ];

  TeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teachers'),
      ),
      body: TeacherList(teachers),
    );
  }
}
