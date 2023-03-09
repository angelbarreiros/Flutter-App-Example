import 'package:edaman_app/edamam.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const color10 = Color.fromARGB(210, 197, 27, 138);
const color30 = Color.fromARGB(255, 250, 159, 181);
const color60 = Color.fromARGB(255, 253, 224, 221);
const colorb = Color.fromARGB(255, 245, 245, 245);
const Map<String?, String?> _map = {
  "Energy": "kcal",
  "Fat": "g",
  "Saturated": "g",
  "Trans": "g",
  "Monounsaturated": "g",
  "Polyunsaturated": "g",
  "Carbs": "g",
  "Carbohydrates (net)": "g",
  "Fiber": "g",
  "Sugars": "g",
  "Sugars, added": "g",
  "Protein": "g",
  "Cholesterol": "mg",
  "Sodium": "mg",
  "Calcium": "mg",
  "Magnesium": "mg",
  "Potassium": "mg",
  "Iron": "mg",
  "Zinc": "mg",
  "Phosphorus": "mg",
  "Vitamin A": "µg",
  "Vitamin C": "µg",
  "Thiamin (B1)": "mg",
  "Riboflavin (B2)": "MG",
  "Niacin (B3)": "mg",
  "Vitamin B6": "mg",
  "Folate equivalent (total)": "µg",
  "Folate (food)": "µg",
  "Folic acid": "µg",
  "Vitamin B12": "µg",
  "Vitamin D": "µg",
  "Vitamin E": "mg",
  "Vitamin K": "µg",
  "Sugar alcohol": "g",
  "Water": "g"
};

class Labels extends StatelessWidget {
  List<String> lista;
  String tittle;

  Labels({required this.lista, required this.tittle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            tittle,
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
          ),
          elevation: 0,
          backgroundColor: color10,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          color: color60,
          child: ListView.builder(
              itemCount: lista.length,
              itemBuilder: (builder, index) {
                return Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            lista[index].toString(),
                            softWrap: true,
                            maxLines: 5,
                            style: TextStyle(fontSize: 24, color: color10),
                          ),
                        )
                      ],
                    ));
              }),
        ));
  }
}

class NutrientList extends StatelessWidget {
  List<Nutrient> lista;
  String tittle;

  NutrientList({required this.lista, required this.tittle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            tittle,
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
          ),
          elevation: 0,
          backgroundColor: color10,
        ),
        body: Container(
          color: color60,
          child: ListView.builder(
              itemCount: lista.length,
              itemBuilder: (builder, index) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(width: 2, color: color30))),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(key:ValueKey(lista[index].label),
                          lista[index].label + ": ",
                          style: TextStyle(color: color10, fontSize: 24),
                        ),
                        Flexible(
                            child: Text(
                          lista[index].value.toStringAsFixed(2) +
                              "" +
                              _map[lista[index].label].toString(),
                          softWrap: true,
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ))
                      ]),
                );
              }),
        ));
  }
}
