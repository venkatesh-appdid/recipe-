import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venkatesh/controllers/home_controller.dart';
import 'package:venkatesh/services/extensions.dart';
import 'package:venkatesh/services/route_helper.dart';
import 'package:venkatesh/views/base/custom_widget.dart/custom_image.dart';
import 'package:venkatesh/views/screens/drawer/app_drawer.dart';
import 'package:venkatesh/views/screens/meal_details.dart/meal_details.dart';
import 'package:venkatesh/views/screens/secondCustomAppBar/second_cust_appbar.dart';

class ListOfMealScreen extends StatefulWidget {
  final String categoryName;
  const ListOfMealScreen({super.key, required this.categoryName});

  @override
  State<ListOfMealScreen> createState() => _ListOfMealScreenState();
}

class _ListOfMealScreenState extends State<ListOfMealScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<HomeController>().getClickOnAnyCategory(widget.categoryName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: SecondCustomAppBar(scaffoldKey: _scaffoldKey),

      body: GetBuilder<HomeController>(
        builder: (homeController) {
          return homeController.isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: homeController.mealModel.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final meal = homeController.mealModel[index];
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          getCustomRoute(
                            child: MealDetails(
                              id: meal.idMeal.toString(),
                              isForRandom: false,
                            ),
                          ),
                        );
                      },
                      leading: CustomImage(
                        height: 100,
                        width: 100,
                        path: meal.strMealThumb.getIfValid,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        meal.strMeal.getOrUnknown,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        meal.idMeal.getOrUnknown,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
