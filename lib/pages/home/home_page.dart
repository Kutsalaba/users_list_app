import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:users_list_app/controllers/network_connection_controller.dart';
import 'package:users_list_app/controllers/users_controller.dart';
import 'package:users_list_app/pages/home/widgets/user_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    UsersController usersController = Get.find();
    NetworkConnectionController networkConnectionController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List of users',
          style: Theme.of(context).primaryTextTheme.titleLarge,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          if (networkConnectionController.isConnectedToInternet()) {
            await usersController.setUsersFromLocal();
          } else {
            await usersController.setUsersToList();
          }
        },
        child: FutureBuilder(
          future: networkConnectionController.isConnectedToInternet()
              ? usersController.getUsers()
              : usersController.setUsersFromLocal(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasError) {
              if (usersController.usersList.isNotEmpty || snapshot.hasData) {
                return Obx(
                  () {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: usersController.usersList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 5.h,
                                ),
                                child: UserCard(
                                  userData: usersController.usersList[index],
                                ),
                              );
                            },
                            shrinkWrap: true,
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            }
            return Center(child: Text('Something went wrong'));
          },
        ),
      ),
    );
  }
}
