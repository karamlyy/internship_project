import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
import 'package:language_learning/presenter/screens/home/provider/home_provider.dart';
import 'package:language_learning/presenter/screens/home/view/home_body.dart';
import 'package:language_learning/presenter/widgets/secondary_floating_bottom_navbar.dart';

import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ChangeNotifierProvider(
            create: (context) => HomeProvider(),
            child: BlocListener<HomeCubit, BaseState>(
              listener: (context, state) {},
              child: const HomeBody(),
            ),
          ),
          SecondaryFloatingBottomNavbar()
        ],
      ),

    );
  }
}
