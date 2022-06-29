import 'package:best_pratique/blocs/users.bloc.dart';
import 'package:best_pratique/ui/pages/git.user.repositories.pages.dart';
import 'package:best_pratique/ui/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class GitUsersPage extends StatelessWidget {
  const GitUsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
            if (state is SearchUsersSuccessState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Users"),
                  Text("${state.currentPage}/${state.totalPage}")
                ],
              );
            } else {
              return const Text("Users Pages");
            }
          }),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(20),
                    )),
                  )),
                  IconButton(
                      onPressed: () {
                        String kw = textEditingController.text;
                        context.read<UsersBloc>().add(SearchUsersEvent(
                            keyword: kw, page: 0, pageSize: 40));
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
            ),
            BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
              if (state is SearchUsersLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SearchUsersErrorState) {
                return Column(
                  children: [
                    Text(
                      state.errorMessage,
                      style: CustomThemes.errorTextStyle,
                    ),
                    ElevatedButton(onPressed: () {
                      UsersBloc usersBloc=context.read<UsersBloc>();
                      usersBloc.add(usersBloc.currentEvent);
                    }, child: const Text("Retry"))
                  ],
                );
              } else if (state is SearchUsersSuccessState) {
                return Expanded(
                  child: LazyLoadScrollView(
                    onEndOfPage: () {
                      context.read<UsersBloc>().add(NextPageEvent(keyword:state.currentKeyword ,page:state.currentPage+1 ,pageSize: state.pageSize));
                    },
                    child: ListView.separated(
                        itemBuilder: (context, index) =>
                            ListTile(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>GitRepositories(user: state.users[index],)));
                              },
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,

                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(state
                                              .users[index].avatarUrl),
                                          radius: 25,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          state.users[index].login,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ],
                                    ),
                                  ),
                                  CircleAvatar(
                                    child: Text("${state.users[index].score.floor()}"),
                                  )
                                ],
                              ),
                            ),
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 8,
                          );
                        },
                        itemCount: state.users.length),
                  ),
                );
              } else {
                return Container();
              }
            })
          ],
        ));
  }
}
