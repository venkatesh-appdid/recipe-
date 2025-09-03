import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:venkatesh/controllers/home_controller.dart';
import 'package:venkatesh/services/route_helper.dart';
import 'package:venkatesh/views/screens/drawer/app_drawer.dart';
import 'package:venkatesh/views/screens/meal_details.dart/meal_details.dart';
import 'package:venkatesh/views/screens/secondCustomAppBar/second_cust_appbar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  searchFun(String search) async {
    try {
      await Get.find<HomeController>().getSearchMeal(search).then((value) {
        if (value.isSuccess) {
          Navigator.of(context).push(getCustomRoute(child: MealDetails()));
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                "No Recipe Found",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                "No Recipe found with name $search",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontSize: 14),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Ok"),
                ),
              ],
            ),
          );
        }
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            drawer: CustomDrawer(),
            appBar: SecondCustomAppBar(scaffoldKey: _scaffoldKey),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),

              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for meals...',
                        prefixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      final query = searchController.text.trim();
                      if (query.isNotEmpty) {
                        searchFun(query);
                      }
                    },
                    child: Text(
                      "Search",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
