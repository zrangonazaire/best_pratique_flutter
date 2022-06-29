import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_repository_dart_event.dart';
part 'user_repository_dart_state.dart';

class UserRepositoryDartBloc extends Bloc<UserRepositoryDartEvent, UserRepositoryDartState> {
  UserRepositoryDartBloc() : super(UserRepositoryDartInitial()) {
    on<UserRepositoryDartEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
