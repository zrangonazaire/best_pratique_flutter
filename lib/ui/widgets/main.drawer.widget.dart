
import 'package:best_pratique/ui/widgets/main.drawer.header.widget.dart';
import 'package:flutter/material.dart';

import 'drawer.item.widget.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic>menu=[
      {"title": "Home","route":"/","leadingIcon": Icons.home,"trailingIcon": Icons.arrow_forward},
      {"title": "Counter Stful","route":"/counter1","leadingIcon": Icons.event,"trailingIcon": Icons.arrow_forward},
      {"title": "Counter Bloc","route":"/counter2","leadingIcon": Icons.timer,"trailingIcon": Icons.arrow_forward},
      {"title": "Git users","route":"/users","leadingIcon": Icons.person,"trailingIcon": Icons.arrow_forward}
    ];
    return Drawer(
      child: Column(
        children:  [
 const MainDrawerHeader(),
Expanded(
  child: ListView.separated(itemBuilder: (context,index){
    return
      DrawerItemWidget(
          title: menu[index]["title"],
          leadingIcon: menu[index]["leadingIcon"],
          trailingIcon: menu[index]["trailingIcon"],
          onAction: (){

     Navigator.pop(context);
      Navigator.pushNamed(context,  menu[index]['route']);
    });
  }, separatorBuilder: (context,index){
    return const Divider(height: 6,);
  }, itemCount: menu.length),
)
        ],
      ),
    );
  }
}
