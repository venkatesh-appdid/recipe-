import 'package:flutter/material.dart';
import 'package:venkatesh/services/route_helper.dart';
import 'package:venkatesh/views/base/custom_widget.dart/custom_appbar.dart';
import 'package:venkatesh/views/screens/search_screen/search_screen.dart';

class SecondCustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SecondCustomAppBar({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      backgroundColor: Colors.orange,
      title: "Recipe App",
      leading: IconButton(
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        icon: Icon(Icons.menu),
      ),
      titleColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(getCustomRoute(child: SearchScreen()));
          },
          icon: Icon(Icons.search),
        ),
      ],
    );
  }
}
