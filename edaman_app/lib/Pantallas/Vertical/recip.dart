import 'package:edaman_app/Pantallas/Vertical/labels.dart';
import 'package:edaman_app/edamam.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  Recipe recipe;

  Description({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          recipe.label!,
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
        ),
        elevation: 0,
        backgroundColor: color10,
      ),
      body: Container(
          padding: const EdgeInsets.only(left: 18, right: 18),
          decoration: const BoxDecoration(color: color60),
          child: ListView(
            children: [
              Image.network(recipe.image!),
              Container(
                padding: EdgeInsets.only(left: 15, top: 10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  const Text("Nº of servings: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color10,
                        fontSize: 20,
                      )),
                  Text(
                      recipe.servings != null
                          ? recipe.servings.toString()
                          : "  Undefined",
                      style: const TextStyle(color: Colors.black, fontSize: 20))
                ]),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, top: 10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  const Text("Nº of calories: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color10,
                        fontSize: 20,
                      )),
                  Text(
                      recipe.calories != null
                          ? recipe.calories!.toStringAsFixed(2) + " kcal"
                          : "  Undefined",
                      style: const TextStyle(color: Colors.black, fontSize: 20))
                ]),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, top: 10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  const Text("Nº of glycemicIndex: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color10,
                        fontSize: 20,
                      )),
                  Text(
                      recipe.glycemicIndex != null
                          ? recipe.glycemicIndex.toString()
                          : "  Undefined",
                      style: const TextStyle(color: Colors.black, fontSize: 20))
                ]),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, top: 10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  const Text("Nº of totalCO2Emissions: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color10,
                        fontSize: 20,
                      )),
                  Text(
                      recipe.totalCO2Emissions != null
                          ? recipe.totalCO2Emissions!.toStringAsFixed(2)
                          : "  Undefined",
                      style: const TextStyle(color: Colors.black, fontSize: 20))
                ]),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, top: 10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  const Text("Class of co2EmissionsClass: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color10,
                        fontSize: 20,
                      )),
                  Text(
                      recipe.co2EmissionsClass != null
                          ? recipe.co2EmissionsClass.toString()
                          : "  Undifined",
                      style: const TextStyle(color: Colors.black, fontSize: 20))
                ]),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, top: 10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  const Text("Cook Time: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color10,
                        fontSize: 20,
                      )),
                  Text(
                      recipe.totalTime != null
                          ? recipe.totalTime.toString() + "mins"
                          : "  Undefined",
                      style: const TextStyle(color: Colors.black, fontSize: 20))
                ]),
              ),
              ExpansionTile(
                title: Text("CousineType"),
                children: recipe.cuisineType!.map((e) {
                  return ListTile(
                    title: Text(
                      e,
                    ),
                  );
                }).toList(),
              ),
              ExpansionTile(
                title: Text("MealType"),
                children: recipe.mealType!.map((e) {
                  return ListTile(
                    title: Text(
                      e,
                    ),
                  );
                }).toList(),
              ),
              ExpansionTile(
                title: Text("DishType"),
                children: recipe.dishType!.map((e) {
                  return ListTile(
                    title: Text(
                      e,
                    ),
                  );
                }).toList(),
              ),
              ExpansionTile(
                title: Text("DietLables"),
                children: recipe.dietLabels!.map((e) {
                  return ListTile(
                    title: Text(
                      e,
                    ),
                  );
                }).toList(),
              ),
              ExpansionTile(
                title: Text("Cautions"),
                children: recipe.cautions!.map((e) {
                  return ListTile(
                    title: Text(
                      e,
                    ),
                  );
                }).toList(),
              ),
              TextButton(key: ValueKey("nutrients"),
                  style: TextButton.styleFrom(
                      backgroundColor: color30, foregroundColor: Colors.black),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return NutrientList(
                          lista: recipe.totalNutrients!,
                          tittle: "TotalNutrients");
                    }));
                  },
                  child: Text("TotalNutrients")),
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: color30, foregroundColor: Colors.black),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Labels(
                          lista: recipe.healthLabels!, tittle: "HealthLabels");
                    }));
                  },
                  child: Text("HealthLabels")),
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: color30, foregroundColor: Colors.black),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Labels(
                          lista: recipe.ingredients!, tittle: "Ingredients");
                    }));
                  },
                  child: Text("Ingredients")),
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: color30, foregroundColor: Colors.black),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return NutrientList(
                          lista: recipe.totalDaily!, tittle: "TotalDaily");
                    }));
                  },
                  child: Text("TotalDaily")),
            ],
          )),
    );
  }
}
