import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/endpoint/auth/register_endpoint.dart';
import 'package:language_learning/data/repository/auth_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/data/service/preferences/preferences.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';

class RegisterCubit extends Cubit<BaseState> {
  RegisterCubit() : super(InitialState());

  final _authRepository = getIt<AuthRepository>();

  void register(RegisterInput input) async {
    emit(LoadingState());
    final result = await _authRepository.register(input);
    final prefs = await PreferencesService.instance;
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        prefs.setUserId(data.userId ?? "");


        emit(SuccessState(data: data));
        Navigation.push(
          Routes.verification,
          arguments: data,
        );
      },
    );
  }
}
