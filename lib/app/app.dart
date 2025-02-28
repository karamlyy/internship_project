import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/app/app_cubit.dart';
import 'package:language_learning/app/app_state.dart';
import 'package:language_learning/presenter/screens/auth/languages/view/set_language_page.dart';
import 'package:language_learning/presenter/screens/auth/login/view/login_page.dart';
import 'package:language_learning/presenter/screens/auth/onboarding/view/onboarding_page.dart';
import 'package:language_learning/presenter/screens/auth/splash/view/splash_page.dart';
import 'package:language_learning/presenter/screens/auth/timing/view/timing_page.dart';
import 'package:language_learning/presenter/screens/configuration/cubit/configuration_cubit.dart';
import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
import 'package:language_learning/presenter/screens/home/view/home_page.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:language_learning/utils/routes/navigation.dart';
import 'package:language_learning/utils/routes/route_generator.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  final String initialLang;

  const App({super.key, required this.initialLang});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      saveLocale: true,
      startLocale: Locale(initialLang),
      supportedLocales: const [
        Locale("az"), // The supported locales, only Azerbaijani is enabled.
        Locale("en"), // The supported locales, only Azerbaijani is enabled.
        Locale("ru"), // The supported locales, only Azerbaijani is enabled.
      ],
      path: "assets/translation", // Path to the translation files.

      fallbackLocale: const Locale("en"), // Fallback to English if a locale is unsupported.
      child: ScreenUtilInit(
        designSize: const Size(375, 852),
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => AppCubit()),
              BlocProvider(create: (_) => HomeCubit()),
            ],
            child: MaterialApp(
              locale: context.locale,
              // Locale configuration for localization.
              supportedLocales: context.supportedLocales,
              // Supported languages for the app.
              localizationsDelegates: context.localizationDelegates,
              theme: ThemeData(
                fontFamily: 'DMSans',
                useMaterial3: true,
                scaffoldBackgroundColor: AppColors.appBarBackground,
                pageTransitionsTheme: const PageTransitionsTheme(
                  builders: {
                    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                    TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                  },
                ),
              ),
              debugShowCheckedModeBanner: false,
              navigatorKey: Navigation.navigatorKey,
              onGenerateRoute: generateRoute,
              home: BlocConsumer<AppCubit, AppState>(
                builder: (context, state) {
                  if (state is Onboarding) {
                    return const OnboardingPage();
                  } else if (state is Unauthorized) {
                    return const LoginPage();
                  } else if (state is Authorized) {
                    return const HomePage();
                  }
                  return const SplashPage();
                },
                listener: (context, state) {},
              ),
            ),
          );
        },
      ),
    );
  }
}
