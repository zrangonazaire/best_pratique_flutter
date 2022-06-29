import 'package:best_pratique/model/user.model.dart';
import 'package:flutter/material.dart';

class GitRepositories extends StatelessWidget {
  final User user;
  const GitRepositories({Key? key,required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User ${user.login} repositories"),
      ),
    );
  }
}
