import 'package:edaman_app/edamam.dart';
import 'package:edaman_app/edamanapp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => (AditionalVariablesHorizontal())),
      ChangeNotifierProvider(create: (_) => (Condiciones())),
      ChangeNotifierProvider(create: (_) => (FormState())),
      ChangeNotifierProvider(create: (_) => (ListState())),
    ],
    child: MyApp(title: 'ReshitoUDC'),
  ));
}

class FormState extends ChangeNotifier {
  List<String> filterDropDown = [
    "Alcohol-cocktail",
    "Alcohol-free",
    "Celery-free",
    "Crustacean-Free",
    "Dairy-free",
    "Egg-free",
    "Fish-free",
    "Fodmap-free",
    "Gluten-free",
    "Inmuno-supportive",
    "Keto-friendly",
    "Kosher",
    "Low-potassium",
    "Low-sugar",
    "Mollusk-free",
    "Mustard-free",
    "No-oil-added",
    "Peanut-free",
    "Pork-free",
    "Soy-free",
    "Tree-nut-free",
    "Vegetarian",
    "Vegan"
  ];

  String busqueda = "";

  String getBusqueda() {
    return this.busqueda;
  }

  List<String> getFilterDropDown() {
    return this.filterDropDown;
  }

  void setBusqueda(String busqueda) {
    this.busqueda = busqueda;
    notifyListeners();
  }

  void changeFirst(String value) {
    String primero = filterDropDown.first;
    int cambio = filterDropDown.indexOf(value);
    filterDropDown.first = value;
    filterDropDown[cambio] = primero;
    notifyListeners();
  }
}

class ListState extends ChangeNotifier {
  List<Recipe> lista = [];
  List<String> stack = [];
  bool iniciarSpinnerBusqueda = false;
  bool cancelClicked = false;
  bool formatError = false;
  bool searchError = false;
  String firstblock = "";

  void pop() {
    stack.removeLast();
    notifyListeners();
  }

  void push(String x) {
    stack.add(x);
    notifyListeners();
  }

  String peek() {
    return stack.last;
  }

  String getFirstCount() {
    return this.firstblock;
  }

  int getSize() {
    return this.lista.length;
  }

  bool getSpinnerBusqueda() {
    return this.iniciarSpinnerBusqueda;
  }

  List<Recipe> getLista() {
    return this.lista;
  }

  void setLista(List<Recipe> lista) {
    this.lista = lista;
    notifyListeners();
  }

  void setCancelClicked(bool yes) {
    this.cancelClicked = yes;
    notifyListeners();
  }

  void setSpinnerBusqueda(bool iniciar) {
    this.iniciarSpinnerBusqueda = iniciar;
    notifyListeners();
  }

  void searchRecipes(String value, String filter, String count, bool primero) {
    if (lista.isNotEmpty) {
      lista.clear();
    }
    searchrecipes(value, filter, count, primero).then((value) {
      iniciarSpinnerBusqueda = false;
      notifyListeners();

      try {
        List<String>? corte =
            value?.nextBlock?.split("https://api.edamam.com/api/recipes/v2?");
        this.firstblock = corte![1].trim();
      } catch (e) {
        formatError = true;
        searchError = false;
        lista.clear();
        stack.clear();
        notifyListeners();
      }

      value?.recipes?.forEach((element) {
        if (element != null && cancelClicked == false) {
          lista.add(element);
        }
        formatError = false;
        searchError = false;
        notifyListeners();
      });
    }).catchError((e) {
      searchError = true;
      formatError = false;
      iniciarSpinnerBusqueda = false;
      lista.clear();
      notifyListeners();
    });
  }
}

class Condiciones extends ChangeNotifier {
  bool nextunsensitive = true;

  void setNextUnsensitive(bool condicion) {
    this.nextunsensitive = condicion;
    notifyListeners();
  }

  bool prevunsensitive = true;

  void setPrevUnsensitive(bool condicion) {
    this.prevunsensitive = condicion;
    notifyListeners();
  }
}

class AditionalVariablesHorizontal extends ChangeNotifier {
  Recipe recipe = Recipe(
      label: "",
      image:
          "https://scontent.fvgo3-1.fna.fbcdn.net/v/t39.30808-6/315560245_3065179080446972_3985530688118113763_n.jpg?stp=cp6_dst-jpg&_nc_cat=108&ccb=1-7&_nc_sid=730e14&_nc_ohc=pZBY6uB7v2UAX-s7hDM&_nc_ht=scontent.fvgo3-1.fna&oh=00_AfBHD8hnDpiqvzm_svyydQioxh7WorXqURe3RJH-PQN1UQ&oe=63768EB2");

  void setRecipe(Recipe recipe) {
    this.recipe = recipe;
    notifyListeners();
  }
}
