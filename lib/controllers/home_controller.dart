import 'dart:developer';

import 'package:get/get.dart';
import 'package:venkatesh/data/models/home/category_model.dart';
import 'package:venkatesh/data/models/home/meal_detail_model.dart';
import 'package:venkatesh/data/models/home/meal_model.dart';
import 'package:venkatesh/data/models/response/response_model.dart';
import 'package:venkatesh/data/repositories/home_repo.dart';

class HomeController extends GetxController implements GetxService {
  final HomeRepo homepageRepo;

  HomeController({required this.homepageRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<CategoryModel> category = [];

  Future<ResponseModel> getHome() async {
    ResponseModel responseModel;

    _isLoading = true;
    update();
    log("response.body.toString()", name: "getHome");
    try {
      Response response = await homepageRepo.getHomeScreen();
      log(response.statusCode.toString());
      log(response.bodyString.toString(), name: "getHome");
      if (response.statusCode == 200) {
        category = (response.body["categories"] as List)
            .map((category) => CategoryModel.fromJson(category))
            .toList();
        responseModel = ResponseModel(
          true,
          '${response.body['message']}',
          response.body,
        );
      } else {
        responseModel = ResponseModel(
          false,
          '${response.body['message']}',
          response.body,
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "CATCH");
      log(
        '++++++++++++++ ${e.toString()} ++++++++++++++',
        name: "ERROR AT getHome()",
      );
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  List<MealModel> mealModel = [];

  Future<ResponseModel> getClickOnAnyCategory(String categoryName) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await homepageRepo.getFilerCategory(categoryName);
      log(response.statusCode.toString());
      log(response.bodyString.toString(), name: "getClickOnAnyCategory");
      if (response.statusCode == 200) {
        mealModel = (response.body["meals"] as List)
            .map((meal) => MealModel.fromJson(meal))
            .toList();

        responseModel = ResponseModel(
          true,
          '${response.body['message']}',
          response.body,
        );
      } else {
        responseModel = ResponseModel(
          false,
          '${response.body['message']}',
          response.body,
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "CATCH");
      log(
        '++++++++++++++ ${e.toString()} ++++++++++++++',
        name: "ERROR AT getClickOnAnyCategory()",
      );
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  MealDetailsModel? mealDetailsModel;

  Future<ResponseModel> getMealDetail(
    String? mealId, {
    required bool isForRandom,
  }) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      log("///////////////////// isForRandom: ${isForRandom}");
      Response response;
      response = isForRandom
          ? await homepageRepo.getRandomMeal()
          : await homepageRepo.getMealDetail(mealId!);

      log(response.statusCode.toString());
      log(response.bodyString.toString(), name: "getMealDetail");
      if (response.statusCode == 200) {
        mealDetailsModel = (response.body['meals'] as List)
            .map((meal) => MealDetailsModel.fromJson(meal))
            .toList()
            .first;

        responseModel = ResponseModel(
          true,
          '${response.body['message']}',
          response.body,
        );
      } else {
        responseModel = ResponseModel(
          false,
          '${response.body['message']}',
          response.body,
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "CATCH");
      log(
        '++++++++++++++ ${e.toString()} ++++++++++++++',
        name: "ERROR AT getMealDetail()",
      );
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> getSearchMeal(String mealName) async {
    ResponseModel responseModel;
    _isLoading = true;
    mealDetailsModel = null;
    update();
    try {
      Response response = await homepageRepo.getSearchMeal(mealName);

      log(response.statusCode.toString());
      log(response.bodyString.toString(), name: "getSearchMeal");
      
      if (response.statusCode == 200) {
        mealDetailsModel = (response.body['meals'] as List)
            .map((meal) => MealDetailsModel.fromJson(meal))
            .toList()
            .first;

        responseModel = ResponseModel(
          true,
          '${response.body['message']}',
          response.body,
        );
      } else {
        responseModel = ResponseModel(
          false,
          '${response.body['message']}',
          response.body,
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "CATCH");
      log(
        '++++++++++++++ ${e.toString()} ++++++++++++++',
        name: "ERROR AT getSearchMeal()",
      );
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}
