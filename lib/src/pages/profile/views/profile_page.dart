import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/app/resources/resources.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:magic_express_delivery/src/utils/utils.dart';
import 'package:repositories/repositories.dart';
import 'package:workmanager/workmanager.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, User>(
      selector: (s) => s.user,
      builder: (_, user) => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.topCenter,
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage(AppImages.PROFILE_PICTURE),
                width: MediaQuery.of(context).size.width * .25,
                height: MediaQuery.of(context).size.width * .25,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              '${user.firstName} ${user.lastName}',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    user.email,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                Flexible(
                  child: Text(
                    user.phoneNumber,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
            const SizedBox(height: 32),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(ChangePasswordPage.route());
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  tileColor: Colors.grey.shade50,
                  title: Text(
                    'Change Password',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Theme.of(context).primaryColorDark,
                    size: 16,
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        title: Text('Are you sure you want to log out?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              final isRider = context.read<AppBloc>().state.isRider;
                              if (isRider) {
                                Workmanager().cancelAll();
                              }
                              context.read<AuthRepo>().logOut();
                              AppKeys.navigatorKey.currentState?.pushAndRemoveUntil(
                                LoginPage.route(),
                                    (route) => false,
                              );
                            },
                            child: Text('Yes'),
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context, rootNavigator: true).pop(),
                            child: Text('No'),
                          )
                        ],
                      ),
                    );
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  tileColor: Colors.grey.shade50,
                  title: Text(
                    'Log out',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Theme.of(context).primaryColorDark,
                    size: 16,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
