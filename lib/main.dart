

import 'package:best_pratique/blocs/counter.bloc.dart';
import 'package:best_pratique/blocs/theme.bloc.dart';
import 'package:best_pratique/blocs/users.bloc.dart';
import 'package:best_pratique/ui/pages/routeview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers:  [
      BlocProvider(create: (context)=>CounterBloc()),
      BlocProvider(create: (context)=>ThemeBloc()),
      BlocProvider(create: (context)=>UsersBloc())
    ],
      child: const RouteView(),);
  }
}
