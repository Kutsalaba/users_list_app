import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:users_list_app/domain/shared_models/api/user_data.dart';
import 'package:users_list_app/styles/app_colors.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.userData,
  });

  final UserData userData;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.incrementalBlueColor,
      child: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: userData.avatarUrl ??
                  'https://avatars.githubusercontent.com/u/72203151?s=400&u=afb87dba1bf28a0797c1b4fdacd34002e31b5741&v=4',
              width: 64.w,
              fit: BoxFit.fitHeight,
              errorWidget: (context, url, error) {
                return Column(
                  children: [
                    Container(
                      width: 64.w,
                      height: 64.h,
                      color: Colors.blue,
                    ),
                    Container(
                      width: 64.w,
                      height: 64.h,
                      color: Colors.yellow,
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userData.email,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Visibility(
                    visible:
                        userData.firstName != null && userData.lastName != null,
                    child: Text(
                      "${userData.firstName} ${userData.lastName}",
                      style: Theme.of(context).primaryTextTheme.displayMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
