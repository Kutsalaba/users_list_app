import 'package:get/get_connect/connect.dart';
import 'package:users_list_app/domain/core/errors/exception/api_exception.dart';
import 'package:users_list_app/domain/shared_models/api/user_data.dart';
import 'package:users_list_app/domain/shared_models/api/user_details.dart';

class UsersProvider extends GetConnect {
  Future<UserDetails> fetchUser(int id) async {
    try {
      var response = await get('https://reqres.in/api/users/$id');
      if (response.statusCode == 200) {
        var userDetails = UserDetails.fromJson(response.body);
        return userDetails;
      } else {
        throw ApiException('Invalid status code');
      }
    } on ApiException catch (e) {
      throw ApiException(e.message);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<List<UserData>> fetchUsers([int numPage = 1]) async {
    var totalPage = 1;
    var users = <UserData>[];
    try {
      do {
        var response = await get('https://reqres.in/api/users?page=$numPage');
        if (response.statusCode == 200) {
          var body = response.body as Map;
          if (body.containsKey('total_pages')) {
            totalPage = body['total_pages'];
          }

          var fetchedUsers = ((body['data'] as List).map<UserData>(
            (user) => UserData.fromJson(user),
          )).toList();
          users.addAll(fetchedUsers);
          numPage++;
        } else {
          throw ApiException('Invalid status code');
        }
      } while (numPage <= totalPage);
    } on ApiException catch (e) {
      throw ApiException(e.message);
    } on Exception catch (e) {
      throw Exception(e);
    }

    return users;
  }
}
