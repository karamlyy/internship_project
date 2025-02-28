import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/widgets/primary_bottom_sheet.dart';

class GenericListener<B extends StateStreamable<S>, S>
    extends BlocListener<B, S> {
  const GenericListener({
    super.key,
    required super.listener,
    super.child,
  });

  @override
  BlocWidgetListener<S> get listener {
    return (context, state) {
      super.listener(context, state);

      if (state is FailureState) {

        PrimaryBottomSheet.show(
          context,
          text: state.errorMessage.message,
        );
      }
    };
  }
}
