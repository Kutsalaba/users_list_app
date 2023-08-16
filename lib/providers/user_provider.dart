import 'package:get/get_connect/connect.dart';
import 'package:users_list_app/domain/core/errors/exception/api_exception.dart';
import 'package:users_list_app/domain/shared_models/api/user_data.dart';

class UsersProvider extends GetConnect {
  // Get request
  Future<Response> fetchUser(int id) => get('https://reqres.in/api/users/$id');

  Future<List<UserData>> fetchUsers([int numPage = 1]) async {
    var totalPage = 1;
    var users = <UserData>[];
    try {
      do {
        var response = await get('https://reqres.in/api/users?page=$numPage');
        var body = response.body as Map;
        if (body.containsKey('total_pages')) {
          totalPage = body['total_pages'];
        }

        var fetchedUsers = ((body['data'] as List).map<UserData>(
          (user) => UserData.fromJson(user),
        )).toList();
        users.addAll(fetchedUsers);
        numPage++;
      } while (numPage <= totalPage);
    } on ApiException catch (e) {
      throw ApiException(e.message);
    } on Exception catch (e) {
      throw Exception(e);
    }

    return users;
  }
}
