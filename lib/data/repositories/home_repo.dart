import 'package:get/get_connect/http/src/response/response.dart';
import 'package:venkatesh/data/api/api_client.dart';
import 'package:venkatesh/services/constants.dart';

class HomeRepo {
  final ApiClient apiClient;
  HomeRepo({required this.apiClient});

  //---- get call all api --------

  Future<Response> getHomeScreen() async =>
      await apiClient.getData(AppConstants.homeScreenApi);

  Future<Response> getFilerCategory(String categoryName) async =>
      await apiClient.getData("${AppConstants.filerCategory}?c=$categoryName");

  Future<Response> getCategory() async =>
      await apiClient.getData(AppConstants.anyCategoryScreenApi);

  Future<Response> getMealDetail(String mealDetail) async =>
      await apiClient.getData("${AppConstants.mealDetail}?i=$mealDetail");

  Future<Response> getRandomMeal() async =>
      await apiClient.getData(AppConstants.randomMealScreenApi);

  Future<Response> getSearchMeal(String mealName) async =>
      await apiClient.getData("${AppConstants.searchMealApi}?s=$mealName");
}
