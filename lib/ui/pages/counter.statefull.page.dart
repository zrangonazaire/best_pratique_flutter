import 'package:best_pratique/ui/themes/themes.dart';
import 'package:flutter/material.dart';

class CounterStateFullPage extends StatefulWidget {
  const CounterStateFullPage({Key? key}) : super(key: key);

  @override
  State<CounterStateFullPage> createState() => _CounterStateFullPageState();
}

class _CounterStateFullPageState extends State<CounterStateFullPage> {
  int counter=0;
  String errorMessage='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:AppBar(title:const Text("Counter StateFull") ,
      ),body:  Center(
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Counter value => $counter",style: Theme.of(context).textTheme.headline3),
          (errorMessage!='')?
          Text(errorMessage,style: CustomThemes.errorTextStyle,):const Text("")
        ],
      ),
    ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "dec",
            onPressed: (){
setState((){
  if(counter>0){
    --counter;
    errorMessage='';
  }else{
    errorMessage="Counter can be less than 0";
  }
  });
          },child: const Icon(Icons.remove),),
          const SizedBox(width: 8,),
          FloatingActionButton(
            heroTag:"inc" ,
            onPressed: (){
              setState((){ if(counter<10){
                ++counter;
                errorMessage='';
              }else{
                errorMessage="Counter can be up than 10";
              }});
          },child: const Icon(Icons.add),)
        ],
      ),
    );
  }
}
