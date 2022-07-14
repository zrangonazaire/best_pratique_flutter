import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_repository_dart_event.dart';
part 'user_repository_dart_state.dart';

class UserRepositoryDartBloc extends Bloc<UserRepositoryEvent, UserRepositoryState> {
  UserRepositoryDartBloc() : super(UserRepositoryInitial()) {
    on<UserRepositoryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
