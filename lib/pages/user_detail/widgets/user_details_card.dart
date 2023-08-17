import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:users_list_app/domain/shared_models/api/user_details.dart';
import 'package:users_list_app/styles/app_colors.dart';

class UserDetailsCard extends StatelessWidget {
  const UserDetailsCard({
    super.key,
    required this.userDetails,
  });

  final UserDetails userDetails;

  @override
  Widget build(BuildContext context) {
    var userData = userDetails.data;
    var support = userDetails.support;
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: AppColors.incrementalBlueColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CachedNetworkImage(),
                Image.network(
                  userData.avatarUrl ??
                      'https://avatars.githubusercontent.com/u/72203151?s=400&u=afb87dba1bf28a0797c1b4fdacd34002e31b5741&v=4',
                  width: 160.w,
                  fit: BoxFit.fitHeight,
                ),
                SizedBox(
                  width: 16.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        'ID:',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .displayMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        userData.id.toString(),
                        style: Theme.of(context).primaryTextTheme.displayMedium,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Email:',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .displayMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        userData.email,
                        style: Theme.of(context).primaryTextTheme.displayMedium,
                      ),
                      SizedBox(height: 12.h),
                      Visibility(
                        visible: userData.firstName != null &&
                            userData.lastName != null,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name:',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .displayMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${userData.firstName} ${userData.lastName}",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .displayMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Text(
                    'Support text:',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  support.text ?? 'OK',
                  style: Theme.of(context).primaryTextTheme.displayMedium,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Text(
                    'Support url:',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  support.url ?? 'OK',
                  style: Theme.of(context).primaryTextTheme.displayMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
