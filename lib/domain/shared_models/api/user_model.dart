import 'package:users_list_app/domain/shared_models/api/user_data.dart';
import 'package:users_list_app/domain/shared_models/api/user_details.dart';

class UserModel {
    final UserData data;
    final UserDetails support;

    UserModel({
        required this.data,
        required this.support,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: UserData.fromJson(json["data"]),
        support: UserDetails.fromJson(json["support"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "support": support.toJson(),
    };
}