import 'dart:convert';

import 'package:best_pratique/model/user_git_repository.model.dart';
import 'package:http/http.dart' as http;

class UserGitRepository {
  Future<UserRepository> gitUsers(String login, int pageSize) async {
    String url = "https://api.github.com/users/$login/repos?per_page=$pageSize";
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String,dynamic>userRepositoryMap=json.decode(response.body);
        UserRepository userRepository=UserRepository.fromJson(userRepositoryMap);
        return userRepository;
      }else{
        return throw ("Errors ${response.statusCode}");
      }
    } catch (e) {
      return throw ("Errors ${e.toString()}");
    }
  }
}
