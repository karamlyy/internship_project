import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/statistics/cubit/statistics_cubit.dart';
import 'package:language_learning/presenter/screens/statistics/provider/statistics_provider.dart';
import 'package:language_learning/presenter/screens/statistics/view/statistics_body.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatisticsCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: PrimaryText(
            text: 'Statistics',
            color: AppColors.primaryText,
            fontWeight: FontWeight.w400,
            fontSize: 20,
            fontFamily: 'Inter',
          ),
        ),
        body: ChangeNotifierProvider(
          create: (context) => StatisticsProvider(),
          child: BlocListener<StatisticsCubit, BaseState>(
            listener: (context, state) {},
            child: StatisticsBody(),
          ),
        ),
      ),
    );
  }
}
