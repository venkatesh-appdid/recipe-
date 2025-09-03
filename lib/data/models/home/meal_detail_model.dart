// class MealDetailsModel {
//   final String idMeal;
//   final String strMeal;
//   final String? strMealAlternate;
//   final String strCategory;
//   final String strArea;
//   final String strInstructions;
//   final String? strMealThumb;
//   final String? strTags;
//   final String? strYoutube;
//   final List<String> ingredients;
//   final List<String> measures;
//   final String? strSource;

//   MealDetailsModel({
//     required this.idMeal,
//     required this.strMeal,
//     this.strMealAlternate,
//     required this.strCategory,
//     required this.strArea,
//     required this.strInstructions,
//     required this.strMealThumb,
//     this.strTags,
//     required this.strYoutube,
//     required this.ingredients,
//     required this.measures,
//     this.strSource,
//   });

//   factory MealDetailsModel.fromJson(Map<String, dynamic> json) {
//     List<String> ingredients = [];
//     List<String> measures = [];

//     for (int i = 1; i <= 20; i++) {
//       final ingredient = json['strIngredient$i'];
//       final measure = json['strMeasure$i'];

//       if (ingredient != null &&
//           ingredient.toString().isNotEmpty &&
//           measure != null &&
//           measure.toString().isNotEmpty) {
//         ingredients.add(ingredient.toString());
//         measures.add(measure.toString());
//       }
//     }

//     return MealDetailsModel(
//       idMeal: json['idMeal'],
//       strMeal: json['strMeal'],
//       strMealAlternate: json['strMealAlternate'],
//       strCategory: json['strCategory'],
//       strArea: json['strArea'],
//       strInstructions: json['strInstructions'],
//       strMealThumb: json['strMealThumb'],
//       strTags: json['strTags'],
//       strYoutube: json['strYoutube'],
//       ingredients: ingredients,
//       measures: measures,
//       strSource: json['strSource'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {
//       'idMeal': idMeal,
//       'strMeal': strMeal,
//       'strMealAlternate': strMealAlternate,
//       'strCategory': strCategory,
//       'strArea': strArea,
//       'strInstructions': strInstructions,
//       'strMealThumb': strMealThumb,
//       'strTags': strTags,
//       'strYoutube': strYoutube,
//       'strSource': strSource,
//     };

//     for (int i = 0; i < ingredients.length; i++) {
//       data['strIngredient${i + 1}'] = ingredients[i];
//       data['strMeasure${i + 1}'] = measures[i];
//     }

//     return data;
//   }
// }
class MealDetailsModel {
  final String? idMeal;
  final String? strMeal;
  final String? strMealAlternate;
  final String? strCategory;
  final String? strArea;
  final String? strInstructions;
  final String? strMealThumb;
  final String? strTags;
  final String? strYoutube;
  final List<String>? ingredients;
  final List<String>? measures;
  final String? strSource;

  MealDetailsModel({
    this.idMeal,
    this.strMeal,
    this.strMealAlternate,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    this.ingredients,
    this.measures,
    this.strSource,
  });

  factory MealDetailsModel.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    List<String> measures = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      if (ingredient != null &&
          ingredient.toString().trim().isNotEmpty &&
          measure != null &&
          measure.toString().trim().isNotEmpty) {
        ingredients.add(ingredient.toString());
        measures.add(measure.toString());
      }
    }

    return MealDetailsModel(
      idMeal: json['idMeal'] as String?,
      strMeal: json['strMeal'] as String?,
      strMealAlternate: json['strMealAlternate'] as String?,
      strCategory: json['strCategory'] as String?,
      strArea: json['strArea'] as String?,
      strInstructions: json['strInstructions'] as String?,
      strMealThumb: json['strMealThumb'] as String?,
      strTags: json['strTags'] as String?,
      strYoutube: json['strYoutube'] as String?,
      ingredients: ingredients.isEmpty ? null : ingredients,
      measures: measures.isEmpty ? null : measures,
      strSource: json['strSource'] as String?,
    );
  }

  
}
