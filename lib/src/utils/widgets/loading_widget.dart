import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rikedu/src/utils/constants/files_constants.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(FilesConst.LOTTIE_LOADING,
          width: MediaQuery.of(context).size.width / 4),
    );
  }
}
