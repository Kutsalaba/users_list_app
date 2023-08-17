// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:users_list_app/domain/shared_models/api/user_data.dart';

// class UsersPreferences {
//   static late SharedPreferences _preferences;

//   static const _keyLocalUsersData = 'localUsersData';

//   static Future init() async => _preferences = await SharedPreferences.getInstance();

//   static Future setUsersData(List<UserData> usersData) async => await _preferences.setString(_keyLocalUsersData, jsonusersData);
// }