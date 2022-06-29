import 'package:best_pratique/model/user.model.dart';
import 'package:bloc/bloc.dart';
import 'package:best_pratique/repository/users.repository.dart';

abstract class UserEvent {}

class SearchUsersEvent extends UserEvent {
  final String keyword;
  final int page;
  final int pageSize;
  SearchUsersEvent(
      {required this.keyword, required this.pageSize, required this.page});
}

abstract class UsersState {
  final List<User> users;
  final int currentPage;
  final int totalPage;
  final int pageSize;
  final String currentKeyword;


  const UsersState(
      {required this.users,
      required this.currentPage,
      required this.totalPage,
      required this.pageSize,
      required this.currentKeyword});
}

class SearchUsersSuccessState extends UsersState {
  SearchUsersSuccessState(
      {required super.users,
      required super.currentPage,
      required super.totalPage,
      required super.pageSize,
      required super.currentKeyword});
}

class SearchUsersLoadingState extends UsersState {
  SearchUsersLoadingState(
      {required super.users,
      required super.currentPage,
      required super.totalPage,
      required super.pageSize,
      required super.currentKeyword});
}

class SearchUsersErrorState extends UsersState {
  final String errorMessage;

  SearchUsersErrorState(
      {required super.users,
      required super.currentPage,
      required super.totalPage,
      required super.pageSize,
      required super.currentKeyword,
      required this.errorMessage});
}

class UsersInitialState extends UsersState {
  UsersInitialState()
      : super(
            users: [],
            pageSize: 20,
            currentPage: 0,
            currentKeyword: "",
            totalPage: 0);
}

class UsersBloc extends Bloc<UserEvent, UsersState> {
  UsersRepository usersRepository = UsersRepository();
 late UserEvent currentEvent;
  UsersBloc() : super(UsersInitialState()) {
    on((SearchUsersEvent event, emit) async {
      currentEvent=event;
      emit(SearchUsersLoadingState(
          currentKeyword: state.currentKeyword,
          totalPage: state.totalPage,
          currentPage: state.currentPage,
          pageSize: state.pageSize,
          users: state.users));
      try {
        ListUsers listUsers = await usersRepository.searchUsers(
            event.keyword, event.page, event.pageSize);
        int totalPages = (listUsers.totalCount / event.pageSize).floor();
        if (listUsers.totalCount % event.pageSize != 0) {
          totalPages = totalPages + 1;
        }
        emit(SearchUsersSuccessState(
            users: listUsers.items,
            totalPage: totalPages,
            currentPage: event.page,
            pageSize: event.pageSize,
            currentKeyword: event.keyword));
      } catch (e) {
        emit(SearchUsersErrorState(
            errorMessage: e.toString()
        ,users: state.users,
        pageSize: state.pageSize
        ,currentPage: state.currentPage
        ,totalPage: state.totalPage,
        currentKeyword: state.currentKeyword));
      }
    });
    on((NextPageEvent event, emit) async {
      currentEvent=event;
print("Nex Page ${event.page}");
      try {
        ListUsers listUsers = await usersRepository.searchUsers(
            event.keyword, event.page, event.pageSize);
        int totalPages = (listUsers.totalCount / event.pageSize).floor();
        if (listUsers.totalCount % event.pageSize != 0) {
          totalPages = totalPages + 1;
        }
        List<User>currentList=[...state.users];
        currentList.addAll(listUsers.items);
        //List<User>current
        emit(SearchUsersSuccessState(
            users: currentList,
            totalPage: totalPages,
            currentPage: event.page,
            pageSize: event.pageSize,
            currentKeyword: event.keyword));
      } catch (e) {
        emit(SearchUsersErrorState(errorMessage: e.toString(),currentKeyword: state.currentKeyword,totalPage: state.totalPage,currentPage: state.currentPage,
        pageSize: state.pageSize,users: state.users));
      }
    });
  }
}

class NextPageEvent extends SearchUsersEvent {
  NextPageEvent(
      {required super.keyword, required super.pageSize, required super.page});
}
