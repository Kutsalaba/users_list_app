import 'package:users_list_app/domain/shared_models/api/user_data.dart';

class LocalUsersData {
  final List<UserData> usersData;

  LocalUsersData(this.usersData);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'usersData': usersData.map((x) => x.toJson()).toList(),
    };
  }

  factory LocalUsersData.fromJson(Map<String, dynamic> json) {
    return LocalUsersData(
      List<UserData>.from(
        (json['usersData']).map<UserData>(
          (x) => UserData.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
