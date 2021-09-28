import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:repositories/repositories.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, User>(
      selector: (s) => s.user,
      builder: (_, user) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Image(
              fit: BoxFit.fill,
              image: AssetImage('assets/profile_picture.png'),
              width: MediaQuery.of(context).size.width * .3,
              height: MediaQuery.of(context).size.width * .3,
              color: Colors.blue.shade300.withOpacity(.5),
            ),
            const SizedBox(height: 32),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Card(
                    color: Colors.blue[50]?.withOpacity(1),
                    shadowColor: Colors.blue[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      child: Text.rich(
                        TextSpan(
                          text: 'First Name: ',
                          style: Theme.of(context).textTheme.bodyText1,
                          children: [
                            TextSpan(
                              text: user.firstName,
                              style: Theme.of(context).textTheme.bodyText2,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.blue[50]?.withOpacity(1),
                    shadowColor: Colors.blue[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      child: Text.rich(
                        TextSpan(
                          text: 'Last Name: ',
                          style: Theme.of(context).textTheme.bodyText1,
                          children: [
                            TextSpan(
                              text: user.lastName,
                              style: Theme.of(context).textTheme.bodyText2,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.blue[50]?.withOpacity(1),
                    shadowColor: Colors.blue[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      child: Text.rich(
                        TextSpan(
                          text: 'Email: ',
                          style: Theme.of(context).textTheme.bodyText1,
                          children: [
                            TextSpan(
                              text: user.email.isNotEmpty ? user.email : 'N/A',
                              style: Theme.of(context).textTheme.bodyText2,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.blue[50]?.withOpacity(1),
                    shadowColor: Colors.blue[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      child: Text.rich(
                        TextSpan(
                          text: 'Phone Number: ',
                          style: Theme.of(context).textTheme.bodyText1,
                          children: [
                            TextSpan(
                              text: user.phoneNumber.isNotEmpty
                                  ? user.phoneNumber
                                  : 'N/A',
                              style: Theme.of(context).textTheme.bodyText2,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
