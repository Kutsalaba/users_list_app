import 'package:get/get.dart';
import 'package:users_list_app/domain/shared_models/api/user_data.dart';
import 'package:users_list_app/providers/user_provider.dart';

class UsersController extends GetxController {
  final _userProvider = UsersProvider();
  RxList _usersList = [].obs;

  RxList get usersList => _usersList;

  Future<void> setUsersToList() async {
    _usersList = (await _userProvider.fetchUsers()).obs;
  }

  Future<RxList<UserData>> getUsers() async {
    await setUsersToList();
    return usersList as RxList<UserData>;
  }

  // Future<void> getUser(int id) async {
  //   return (await _userProvider.fetchUser(id)).obs;
  // }
}