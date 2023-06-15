import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/parental_controls/controllers/exercise_controller.dart';
import 'package:rikedu/src/features/parental_controls/models/exercise_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ExerciseDetailViewFilePage extends GetView<ExerciseController> {
  const ExerciseDetailViewFilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final exercise = Get.arguments as Exercise;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        title: Text(
          exercise.subjectName,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
      ),
      body: SfPdfViewer.network(
        exercise.file,
      ),
    );
  }
}
