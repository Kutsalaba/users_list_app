import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:users_list_app/domain/shared_models/api/local_users_data.dart';
import 'package:users_list_app/domain/shared_models/api/user_data.dart';
import 'package:users_list_app/domain/shared_models/api/user_details.dart';
import 'package:users_list_app/providers/user_provider.dart';

class UsersController extends GetxController {
  final _userProvider = UsersProvider();
  late Rx<UserDetails?> _singleUserDetails;
  UserDetails? get singleUserDetails => _singleUserDetails.value;

  final _localUsersData = 'localUsersData';
  final _localSingleUser = 'localSingleUser';

  RxList<UserData> _usersList = <UserData>[].obs;

  RxList<UserData> get usersList => _usersList;

  Future<void> setUsersToList() async {
    _usersList = (await _userProvider.fetchUsers()).obs;
    await saveUsersToLocal();
  }

  Future<RxList<UserData>> getUsers() async {
    await setUsersToList();

    return usersList;
  }

  Future<void> saveUsersToLocal() async {
    var prefs = await SharedPreferences.getInstance();
    var localUsersData = LocalUsersData(_usersList);
    prefs.setString(_localUsersData, jsonEncode(localUsersData));
  }

  Future<void> setUsersFromLocal() async {
    var prefs = await SharedPreferences.getInstance();
    var usersData = prefs.getString(_localUsersData);
    if (usersData == null) return;
    _usersList = LocalUsersData.fromJson(jsonDecode(usersData)).usersData.obs;
  }

  Future<UserDetails> getUser(int id) async {
    return (await _userProvider.fetchUser(id));
  }

  Future<void> setSingleUser(int id) async {
    _singleUserDetails = (await _userProvider.fetchUser(id)).obs;
    await saveSingleUserToLocal();
  }

  Future<void> saveSingleUserToLocal() async {
    var prefs = await SharedPreferences.getInstance();
    var userId = _singleUserDetails.value!.data.id;
    prefs.setString('$_localSingleUser$userId', jsonEncode(_singleUserDetails.value));
  }

   Future<void> setSingleUserFromLocal(int id) async {
    var prefs = await SharedPreferences.getInstance();
    var userDetails = prefs.getString('$_localSingleUser$id');
    if (userDetails == null) {
      _singleUserDetails = null.obs;
      return;
    }
    _singleUserDetails = UserDetails.fromJson(jsonDecode(userDetails)).obs;
  }
}
