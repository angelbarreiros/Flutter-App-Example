import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;

const API_URL = "api.edamam.com";
const ENDPOINT = "api/recipes/v2";
const TYPE = "public";
const APP_ID = "bd30c980";
const APP_KEY = "7ee8b14541c595046a2d93674bf0e850";

class Nutrient {
  String label;
  double value;

  Nutrient(this.label, this.value);

  @override
  String toString() {
    return "\t\tNutrient: $label: $value\n";
  }
}

class Recipe {
  String? uri;
  String? label;
  String? image;
  String? thumbnail;
  String? source;
  String? sourceUrl;
  double? servings;
  List<String>? healthLabels;
  List<String>? dietLabels;
  List<String>? cautions;
  List<String>? ingredients;
  double? calories;
  double? glycemicIndex;
  double? totalCO2Emissions;
  String? co2EmissionsClass;
  double? totalTime;
  List<String>? cuisineType;
  List<String>? mealType;
  List<String>? dishType;
  List<Nutrient>? totalNutrients;
  List<Nutrient>? totalDaily;

  Recipe(
      {this.uri,
      this.label,
      this.image,
      this.thumbnail,
      this.source,
      this.sourceUrl,
      this.servings,
      this.healthLabels,
      this.dietLabels,
      this.cautions,
      this.ingredients,
      this.calories,
      this.glycemicIndex,
      this.totalCO2Emissions,
      this.co2EmissionsClass,
      this.totalTime,
      this.cuisineType,
      this.mealType,
      this.dishType,
      this.totalNutrients,
      this.totalDaily});

  @override
  String toString() {
    return "Recipe: \n" +
        "\tUri: $uri\n" +
        "\tLabel: $label\n" +
        "\tSource: $source\n" +
        "\tSourceUrl: $sourceUrl\n" +
        "\tServings: $servings\n" +
        "\tHealthLabels: $healthLabels\n" +
        "\tDietLabels: $dietLabels\n" +
        "\tCautions: $cautions\n" +
        "\tIngredients: $ingredients\n" +
        "\tCalories: $calories\n" +
        "\tGlycemicIndex: $glycemicIndex\n" +
        "\tTotalCO2Emissions: $totalCO2Emissions\n" +
        "\tCo2EmissionsClass: $co2EmissionsClass\n" +
        "\tTotalTime: $totalTime\n" +
        "\tCuisineType: $cuisineType\n" +
        "\tMealType: $mealType\n" +
        "\tDishType: $dishType\n" +
        "\tTotalNutrients: \n$totalNutrients\n" +
        "\tTotalDaily: \n$totalDaily\n";
  }
}

class RecipeBlock {
  int from;
  int to;
  int count;
  String? nextBlock;
  List<Recipe>? recipes;

  RecipeBlock(
      {required this.from,
      required this.to,
      required this.count,
      this.nextBlock,
      this.recipes});

  @override
  String toString() {
    return "RecipeBlock: From: $from | To: $to | Count: $count\n$recipes\nNextBlock: $nextBlock";
  }
}

class FormatException implements Exception {
  final List<String> msg;

  const FormatException(this.msg);

  @override
  String toString() => "FormatException: $msg";
}

List<String>? parselist(var list) =>
    list != null ? List<String>.from(list) : null;

Future<RecipeBlock?> searchrecipes(
    String query, String filter, String siguiente, bool primero) async {
  var formattedQuery = "";
  if (primero == true) {
    formattedQuery =
        "type=$TYPE&beta=true&app_id=$APP_ID&app_key=$APP_KEY&q=$query";
    formattedQuery = "$formattedQuery&health=$filter";
  } else {
    formattedQuery = siguiente;
  }

  var uri = Uri(
      scheme: "https", host: API_URL, path: ENDPOINT, query: formattedQuery);

  var response = await http.get(uri);
  var data = jsonDecode(response.body);

  if (response.statusCode != 200) {
    List<String> errors = [];
    if (data is List) {
      for (var element in data) {
        errors.add("${element["message"]} ${element["params"]}");
      }
    } else {
      errors.add("${data["message"]} ${data["params"]}");
    }
    throw FormatException(errors);
  }

  RecipeBlock block;

  if (data['count'] == 0) {
    block = RecipeBlock(from: 0, to: 0, count: 0);
  } else {
    List<Recipe> recipes = [];

    for (var hit in data["hits"]) {
      var recipe = hit["recipe"];
      List<Nutrient> totalNutrients = [];
      recipe["totalNutrients"]?.forEach((key, value) {
        totalNutrients.add(Nutrient(value["label"], value["quantity"]));
      });

      List<Nutrient> totalDaily = [];
      recipe["totalDaily"]?.forEach((key, value) {
        totalDaily.add(Nutrient(value["label"], value["quantity"]));
      });

      recipes.add(Recipe(
          uri: recipe["uri"],
          label: recipe["label"],
          image: recipe["image"],
          thumbnail: recipe["images"]["THUMBNAIL"]["url"],
          source: recipe["source"],
          sourceUrl: recipe["url"],
          servings: recipe["yield"],
          dietLabels: parselist(recipe["dietLabels"]),
          healthLabels: parselist(recipe["healthLabels"]),
          cautions: parselist(recipe["cautions"]),
          ingredients: parselist(recipe["ingredientLines"]),
          calories: recipe["calories"],
          glycemicIndex: recipe["glycemicIndex"],
          totalCO2Emissions: recipe["totalCO2Emissions"],
          co2EmissionsClass: recipe["co2EmissionsClass"],
          totalTime: recipe["totalTime"],
          cuisineType: parselist(recipe["cuisineType"]),
          mealType: parselist(recipe["mealType"]),
          dishType: parselist(recipe["dishType"]),
          totalNutrients: totalNutrients,
          totalDaily: totalDaily));
    }

    block = RecipeBlock(
        from: data["from"],
        to: data["to"],
        count: data["count"],
        nextBlock: data["_links"]["next"]["href"],
        recipes: recipes);
  }
  return block;
}
