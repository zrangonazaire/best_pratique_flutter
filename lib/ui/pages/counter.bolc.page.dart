import 'package:best_pratique/blocs/counter.bloc.dart';
import 'package:best_pratique/ui/themes/themes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBlocPage extends StatelessWidget {
  const CounterBlocPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter Bloc"),
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            if (state is CounterSuccessState || state is CounterInitialState) {
              return Text(
                "Counter Value => ${state.counter}",
                style: Theme.of(context).textTheme.headline4,
              );
            } else if (state is CounterErrorState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Counter Value ${state.counter}",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    state.errorMessage,
                    style: CustomThemes.errorTextStyle,
                  )
                ],
              );
            } else {
              return Container();
            }
          },
        ),

      ),
      floatingActionButton: Row(mainAxisAlignment: MainAxisAlignment.end,children: [
        FloatingActionButton(onPressed: (){
          context.read<CounterBloc>().add(DecrementCounterEvent());
        },heroTag: "dec",child: const Icon(Icons.remove),),
        SizedBox(width: 8,),
        FloatingActionButton(onPressed: (){
          context.read<CounterBloc>().add(IncrementCounterEvent());
        },heroTag: "inc",child: const Icon(Icons.add),),
      ],),
    );
  }
}
