import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:venkatesh/controllers/home_controller.dart';
import 'package:venkatesh/data/models/home/meal_detail_model.dart';
import 'package:venkatesh/views/base/custom_widget.dart/custom_image.dart';
import 'package:venkatesh/views/screens/drawer/app_drawer.dart';
import 'package:venkatesh/views/screens/secondCustomAppBar/second_cust_appbar.dart';

class MealDetails extends StatefulWidget {
  final String? id;
  final bool? isForRandom;
  final MealDetailsModel? searchMealData;

  const MealDetails({
    super.key,
    this.id,
    this.isForRandom,
    this.searchMealData,
  });

  @override
  State<MealDetails> createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.searchMealData == null) {
        if (widget.isForRandom == true) {
          Get.find<HomeController>().getMealDetail("", isForRandom: true);
        } else {
          Get.find<HomeController>().getMealDetail(
            widget.id!,
            isForRandom: false,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: widget.isForRandom == true ? null : CustomDrawer(),
      appBar: widget.isForRandom == true
          ? null
          : SecondCustomAppBar(scaffoldKey: _scaffoldKey),
      body: GetBuilder<HomeController>(
        builder: (homeController) {
          final meal;
          widget.searchMealData == null
              ? meal = homeController.mealDetailsModel
              : meal = widget.searchMealData;
          return homeController.isLoading
              ? Align(
                  alignment: Alignment.center,
                  child: Center(child: CircularProgressIndicator()),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImage(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: double.infinity,
                        path: meal?.strMealThumb.toString() ?? "",

                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 12),
                      Text(
                        meal?.strMeal ?? "",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(fontSize: 16),
                      ),
                      SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children: [
                          Chip(
                            label: Text(meal?.strCategory ?? ""),
                            backgroundColor: Colors.orange.shade100,
                          ),

                          // _buildChip("Area: ${meal.strArea}"),
                          Chip(
                            label: Text(meal?.strArea ?? ""),
                            backgroundColor: Colors.orange.shade100,
                          ),
                          if (meal?.strTags != null)
                            ...meal!.strTags!
                                .split(',')
                                .map(
                                  (tag) => Chip(
                                    label: Text(tag.trim() ?? ""),
                                    backgroundColor: Colors.orange.shade100,
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(height: 20),
                      SizedBox(height: 20),

                      // Ingredients
                      Text(
                        "Ingredients",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(fontSize: 14),
                      ),
                      SizedBox(height: 8),
                      Table(
                        columnWidths: {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(1),
                        },
                        border: TableBorder.all(color: Colors.grey.shade300),
                        children: List.generate(
                          meal?.ingredients?.length ?? 0,
                          (index) => TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(meal?.ingredients?[index] ?? ""),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(meal?.measures?[index] ?? ""),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      SizedBox(height: 20),

                      // Instructions
                      Text(
                        "Instructions",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        meal?.strInstructions ?? "",
                        style: TextStyle(fontSize: 14),
                      ),

                      SizedBox(height: 20),
                      // YouTube button
                      if (meal?.strYoutube != null)
                        ElevatedButton.icon(
                          onPressed: () => _launchURL(meal?.strYoutube ?? ""),
                          icon: Icon(Icons.play_arrow),
                          label: Text("Watch on YouTube"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                        ),

                      // Source
                      if (meal?.strSource != null)
                        TextButton(
                          onPressed: () => _launchURL(meal?.strSource ?? ""),
                          child: Text("View Source Recipe"),
                        ),

                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          SharePlus.instance.share(
                            ShareParams(text: 'check out my website '),
                          );
                        },
                        child: Text("Share"),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
