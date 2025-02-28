import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/generic/base_state.dart';

class GenericBuilder<B extends StateStreamable<S>, S> extends BlocBuilder<B, S> {
  const GenericBuilder({
    super.key,
    required super.builder,
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
}