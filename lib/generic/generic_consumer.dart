import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/widgets/primary_bottom_sheet.dart';

class GenericConsumer<B extends StateStreamable<S>, S> extends BlocConsumer<B, S> {
  const GenericConsumer({
    super.key,
    required super.builder,
    required super.listener,
  });

  @override
  BlocWidgetBuilder<S> get builder {
    return (context, state) {
      if (state is LoadingState) {
        return const Center(child: CircularProgressIndicator());
      }

      return super.builder(context, state);
    };
  }

  @override
  BlocWidgetListener<S> get listener {
    return (context, state) {
      if (state is FailureState) {
        PrimaryBottomSheet.show(
          context,
          text: state.errorMessage.message,
        );
      }

      return super.listener(context, state);
    };
  }
}