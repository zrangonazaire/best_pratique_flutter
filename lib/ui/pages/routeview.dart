import 'package:best_pratique/blocs/theme.bloc.dart';
import 'package:best_pratique/ui/pages/counter.bolc.page.dart';
import 'package:best_pratique/ui/pages/counter.statefull.page.dart';
import 'package:best_pratique/ui/pages/git.user.page.dart';
import 'package:best_pratique/ui/pages/home.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class RouteView extends StatelessWidget {
  const RouteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc,ThemeState>(builder: (context,state){
      return MaterialApp(
        theme:state.themeData ,
        routes: {
          "/":(context) => const HomePage(),
          "/counter1":(context) => const CounterStateFullPage(),
          "/counter2":(context) => const CounterBlocPage(),
          "/users":(context) => const GitUsersPage()
        },
        initialRoute: "/",
      );
    });
  }
}