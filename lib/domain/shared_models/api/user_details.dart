import 'package:users_list_app/domain/shared_models/api/support_info.dart';
import 'package:users_list_app/domain/shared_models/api/user_data.dart';

class UserDetails {
    final UserData data;
    final SupportInfo support;

    UserDetails({
        required this.data,
        required this.support,
    });

    factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        data: UserData.fromJson(json["data"]),
        support: SupportInfo.fromJson(json["support"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "support": support.toJson(),
    };
}