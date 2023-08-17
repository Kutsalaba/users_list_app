import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:users_list_app/domain/shared_models/api/local_users_data.dart';
import 'package:users_list_app/domain/shared_models/api/user_data.dart';
import 'package:users_list_app/providers/user_provider.dart';

class UsersController extends GetxController {
  final _userProvider = UsersProvider();

  final _localUsersData = 'localUsersData';
  RxList _usersList = [].obs;

  RxList get usersList => _usersList;

  Future<void> setUsersToList() async {
    _usersList = (await _userProvider.fetchUsers()).obs;
    await saveUsersToLocal();
  }

  Future<RxList<UserData>> getUsers() async {
    await setUsersToList();

    return usersList as RxList<UserData>;
  }

  Future<void> saveUsersToLocal() async {
    var prefs = await SharedPreferences.getInstance();
    var localUsersData = LocalUsersData(_usersList as List<UserData>);
    prefs.setString(_localUsersData, jsonEncode(localUsersData));
  }

  Future<void> setUsersFromLocal() async {
    var prefs = await SharedPreferences.getInstance();
    var usersData = prefs.getString(_localUsersData);
    if (usersData == null) return;
    _usersList = LocalUsersData.fromJson(jsonDecode(usersData)).usersData.obs;
  }

  // Future<void> getUser(int id) async {
  //   return (await _userProvider.fetchUser(id)).obs;
  // }
}
