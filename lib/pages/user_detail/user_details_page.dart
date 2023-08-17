import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:users_list_app/controllers/users_controller.dart';
import 'package:users_list_app/pages/user_detail/widgets/user_details_card.dart';

class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    UsersController usersController = Get.find();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            usersController.singleUserDetails != null
                ? '${usersController.singleUserDetails!.data.firstName} ${usersController.singleUserDetails!.data.lastName}'
                : 'User',
            style: Theme.of(context).primaryTextTheme.titleLarge,
          ),
        ),
        body: usersController.singleUserDetails != null
            ? Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 10.h,
                ),
                child: UserDetailsCard(
                  userDetails: usersController.singleUserDetails!,
                ),
              )
            : Center(
                child: Text(
                  'Check your internet connection',
                  style: Theme.of(context).primaryTextTheme.displayLarge,
                ),
              ),
      ),
    );
  }
}
