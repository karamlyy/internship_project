import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/new-word/cubit/new_word_cubit.dart';
import 'package:language_learning/presenter/widgets/primary_button.dart';
import 'package:path_provider/path_provider.dart';

class NewWordDownload extends StatelessWidget {
  const NewWordDownload({super.key});

  Future<void> downloadFile(String url, String fileName) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      String savePath = '${dir.path}/$fileName';

      Dio dio = Dio();
      await dio.download(url, savePath, onReceiveProgress: (received, total) {
        if (total != -1) {
          print('Download progress: ${(received / total * 100).toStringAsFixed(0)}%');
        }
      });

      print('File saved at $savePath');
    } catch (e) {
      print('Error downloading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewWordCubit, BaseState>(
      listener: (context, state) {
        if (state is FailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.errorMessage}')),
          );
        } else if (state is SuccessState) {
          final filePath = state.data;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('File saved at: $filePath')),
          );
        }
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: PrimaryButton(
            title: 'Download Template',
            hasBorder: true,
            isActive: true,
            onTap: () {
              //context.read<NewWordCubit>().downloadTemplate("https://github.com/karamlyy/db/blob/main/VocabularyTemplate.xlsx");
            },
          ),
        );
      },
    );
  }
}
