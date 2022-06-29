import 'dart:convert';

import 'package:best_pratique/model/user.model.dart';
import 'package:http/http.dart' as http;

class UsersRepository {
  Future<ListUsers> searchUsers(String keyword, int page, int pageSize) async {
    String url =
        "https://api.github.com/search/users?q=$keyword&page=$page&per_page=$pageSize";
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> listUserMap = json.decode(response.body);
        ListUsers listUsers = ListUsers.fromJson(listUserMap);
        return listUsers;
      } else {
        return throw ("Error => ${response.statusCode}");
      }
    } catch (ex) {
      return throw ("Error => ${ex.toString()}");
    }
  }
}
