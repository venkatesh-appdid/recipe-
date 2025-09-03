import 'package:flutter/material.dart';
import 'package:venkatesh/services/route_helper.dart';
import 'package:venkatesh/views/base/dialogs/logout_dialog.dart';
import 'package:venkatesh/views/screens/main_screen/main_screen.dart';
import 'package:venkatesh/views/screens/meal_details.dart/meal_details.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.orange),
            child: Center(
              child: Text(
                "Recipe App",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                getCustomRoute(child: MainScreen(0)),
                (route) => false,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.dinner_dining),
            title: Text('random recipe'),
            onTap: () {
              Navigator.of(context).push(getCustomRoute(child: MainScreen(1)));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              showLogoutDialogue(context: context);

              // await GoogleSignInService.signOut();
              // Navigator.of(context).pushAndRemoveUntil(
              //   getCustomRoute(child: GoogleLoginScreen()),
              //   (route) => false,
              // );
            },
          ),
        ],
      ),
    );
  }
}
