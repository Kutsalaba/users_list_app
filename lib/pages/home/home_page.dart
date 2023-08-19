import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:users_list_app/controllers/users_controller.dart';
import 'package:users_list_app/pages/home/widgets/user_card.dart';
import 'package:users_list_app/pages/user_detail/user_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Connectivity connectivity = Connectivity();
  final UsersController usersController = Get.find();
  bool isConnectedToInternet = false;
  late StreamSubscription<ConnectivityResult> connectionSubscription;

  @override
  void initState() {
    super.initState();
    getConnectivity();

    connectionSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) async {
      print("Network connectivity changed: $connectivityResult");
      await updateConnectionStatus(connectivityResult);
    });
  }

  @override
  void dispose() {
    connectionSubscription.cancel();
    super.dispose();
  }

  Future<void> getConnectivity() async {
    var result = await connectivity.checkConnectivity();

    if (!mounted) {
      return Future.value(null);
    }

    await updateConnectionStatus(result);
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.ethernet ||
        result == ConnectivityResult.mobile) {
      setState(() {
        isConnectedToInternet = true;
      });
    } else {
      setState(() {
        isConnectedToInternet = false;
      });
    }
    await usersController.updateUsers(isConnectedToInternet);
  }

  @override
  Widget build(BuildContext context) {
    log(usersController.usersList.toString());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'List of users',
            style: Theme.of(context).primaryTextTheme.titleLarge,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await usersController.updateUsers(isConnectedToInternet);
            setState(() {});
          },
          child: FutureBuilder(
            future: usersController.updateUsers(isConnectedToInternet),
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
                                  child: GestureDetector(
                                    onTap: () async {
                                      await usersController.updateSingleUser(
                                        isConnectedToInternet,
                                        usersController.usersList[index].id,
                                      );

                                      Get.to(() => const UserDetailsPage());
                                    },
                                    child: UserCard(
                                      userData:
                                          usersController.usersList[index],
                                    ),
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
              return Center(
                child: Text(
                  'Something went wrong',
                  style: Theme.of(context).primaryTextTheme.displayLarge,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
