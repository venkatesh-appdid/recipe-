// To parse this JSON data, do
//
//     final mealModel = mealModelFromJson(jsonString);

import 'dart:convert';

List<MealModel> mealModelFromJson(String str) =>
    List<MealModel>.from(json.decode(str).map((x) => MealModel.fromJson(x)));

String mealModelToJson(List<MealModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MealModel {
  String? strMeal;
  String? strMealThumb;
  String? idMeal;

  MealModel({this.strMeal, this.strMealThumb, this.idMeal});

  factory MealModel.fromJson(Map<String, dynamic> json) => MealModel(
    strMeal: json["strMeal"],
    strMealThumb: json["strMealThumb"],
    idMeal: json["idMeal"],
  );

  Map<String, dynamic> toJson() => {
    "strMeal": strMeal,
    "strMealThumb": strMealThumb,
    "idMeal": idMeal,
  };
}
