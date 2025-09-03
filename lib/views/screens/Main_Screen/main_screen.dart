import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:venkatesh/views/screens/drawer/app_drawer.dart';
import 'package:venkatesh/views/screens/home_screen/home_screen.dart';
import 'package:venkatesh/views/screens/meal_details.dart/meal_details.dart';
import 'package:venkatesh/views/screens/secondCustomAppBar/second_cust_appbar.dart';

class MainScreen extends StatefulWidget {
  final int? selectIndex;
  MainScreen(this.selectIndex, {super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectIndex ?? 0;
  }

  final List<Widget> _page = [
    const HomeScreen(),
    const MealDetails(isForRandom: true),
  ];

  Future<bool> _showExitDialog(BuildContext context) async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Exit App"),
        content: const Text("Do you want to close the app?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Yes"),
          ),
        ],
      ),
    );
    return shouldExit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final exitApp = await _showExitDialog(context);
        if (exitApp) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: CustomDrawer(),
        appBar: SecondCustomAppBar(scaffoldKey: _scaffoldKey),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.dinner_dining),
              label: "Random Meal",
            ),
          ],
        ),
        body: _page[_selectedIndex],
      ),
    );
  }
}
