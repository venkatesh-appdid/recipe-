import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:venkatesh/controllers/home_controller.dart';
import 'package:venkatesh/services/extensions.dart';
import 'package:venkatesh/services/route_helper.dart';
import 'package:venkatesh/views/base/custom_widget.dart/custom_image.dart';
import 'package:venkatesh/views/screens/list_of_meal_screen/list_of_meal_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<HomeController>().getHome();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (homeController) {
          return homeController.isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shrinkWrap: true,
                  itemCount: homeController.category.length,
                  itemBuilder: (context, index) {
                    final category = homeController.category[index];
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          getCustomRoute(
                            child: ListOfMealScreen(
                              categoryName: category.strCategory.getIfValid,
                            ),
                          ),
                        );
                      },
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      leading: CustomImage(
                        height: 100,
                        width: 100,
                        path: category.strCategoryThumb.getIfValid,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        category.strCategory.getOrUnknown,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
