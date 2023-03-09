import 'package:edaman_app/Pantallas/Vertical/recip.dart' as description;
import 'package:edaman_app/edamam.dart';
import 'package:edaman_app/main.dart' as utils;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const color10 = Color.fromARGB(210, 197, 27, 138);
const color30 = Color.fromARGB(255, 250, 159, 181);
const color60 = Color.fromARGB(255, 253, 224, 221);
const colorb = Color.fromARGB(255, 245, 245, 245);

class Vertical extends StatelessWidget {
  final String title;

  Vertical({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        elevation: 0,
        backgroundColor: color10,
      ),
      body: Container(
          padding: const EdgeInsets.only(left: 18, right: 18),
          decoration: const BoxDecoration(color: color60),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Busqueda(),
                const Filtro(),
                FormButtons(),
                FormatError(),
                SearchError(),
                Spinner(),
                const Lista()
              ])),
    );
  }
}

class FormButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrevPage(),
              SearchButton(),
              CancelButton(),
              NextPage()
            ]));
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool ferror = context.watch<utils.ListState>().formatError;
    bool serror = context.watch<utils.ListState>().searchError;
    bool terror = serror || ferror;
    bool unsensitive = context.watch<utils.Condiciones>().nextunsensitive;
    String entrada = context.watch<utils.FormState>().busqueda;
    bool unclicked = entrada == "" || unsensitive;
    String filtro =
        context.watch<utils.FormState>().filterDropDown.first.toLowerCase();
    String busqueda = context.watch<utils.FormState>().busqueda;
    String count = context.watch<utils.ListState>().getFirstCount();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color30),
      onPressed: unclicked  || terror
          ? null
          : () {
              context.read<utils.ListState>().setSpinnerBusqueda(true);
              context
                  .read<utils.ListState>()
                  .searchRecipes(busqueda, filtro, count, false);
              context.read<utils.ListState>().setCancelClicked(false);
              context.read<utils.ListState>().push(count);
              context.read<utils.Condiciones>().setPrevUnsensitive(false);
            },
      child: Text("Next page"),
    );
  }
}

class PrevPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool ferror = context.watch<utils.ListState>().formatError;
    bool serror = context.watch<utils.ListState>().searchError;
    bool terror = serror || ferror;
    bool unsensitive = context.watch<utils.Condiciones>().prevunsensitive;
    List<String> prevstack = context.watch<utils.ListState>().stack;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color30),
      onPressed: unsensitive || terror
          ? null
          : () {
              String uri = "";
              if (prevstack.length <= 2) {
                context.read<utils.ListState>().pop();
                context.read<utils.Condiciones>().setPrevUnsensitive(true);
                uri = prevstack.last;
              } else {
                context.read<utils.ListState>().pop();
                uri = prevstack.last;
              }

              context.read<utils.ListState>().setSpinnerBusqueda(true);
              context.read<utils.ListState>().searchRecipes("", "", uri, false);
              context.read<utils.ListState>().setCancelClicked(false);
            },
      child: Text("Previous"),
    );
  }
}

class FormatError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool show = context.watch<utils.ListState>().formatError;

    return Visibility(
        visible: show,
        child: SizedBox(
            width: 120,
            height: 110,
            child: Image.asset("assets/err_brequest.jpg")));
  }
}

class SearchError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool show = context.watch<utils.ListState>().searchError;

    return Visibility(
        visible: show,
        child: SizedBox(
            width: 120,
            height: 110,
            child: Image.asset("assets/err_nfound.jpg")));
  }
}

class SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool spin = context.watch<utils.ListState>().iniciarSpinnerBusqueda;
    String filtro =
        context.watch<utils.FormState>().filterDropDown.first.toLowerCase();
    String busqueda = context.watch<utils.FormState>().busqueda;
    String count = context.watch<utils.ListState>().getFirstCount();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black, backgroundColor: color30),
      onPressed: spin
          ? null
          : () {
              context.read<utils.ListState>().setSpinnerBusqueda(true);
              context
                  .read<utils.ListState>()
                  .searchRecipes(busqueda, filtro, count, true);
              context.read<utils.ListState>().setCancelClicked(false);
              context.read<utils.Condiciones>().setNextUnsensitive(false);
              context.read<utils.Condiciones>().setPrevUnsensitive(true);
              context.read<utils.ListState>().push(
                  "type=$TYPE&beta=true&app_id=$APP_ID&app_key=$APP_KEY&q=$busqueda" +
                      "&health=$filtro");
            },
      child: Text("Search"),
    );
  }
}

class CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool spin = context.watch<utils.ListState>().iniciarSpinnerBusqueda;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color30),
      onPressed: !spin
          ? null
          : () {
              context.read<utils.ListState>().setSpinnerBusqueda(false);
              context.read<utils.ListState>().setCancelClicked(true);
              context.read<utils.Condiciones>().setNextUnsensitive(true);
              context.read<utils.Condiciones>().setPrevUnsensitive(true);
            },
      child: Text("Cancel"),
    );
  }
}

class Spinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool spin = context.watch<utils.ListState>().iniciarSpinnerBusqueda;
    return Visibility(child: CircularProgressIndicator(), visible: spin);
  }
}

class Busqueda extends StatelessWidget {
  Busqueda({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: TextField(
          onSubmitted: (value) {
            context.read<utils.FormState>().setBusqueda(value);
          },
          onChanged: (value) {
            context.read<utils.FormState>().setBusqueda(value);
            context.read<utils.Condiciones>().setPrevUnsensitive(true);
            context.read<utils.Condiciones>().setNextUnsensitive(true);
            context.read<utils.ListState>().stack.clear();
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: color10),
              fillColor: color60,
              filled: true,
              hintText: "Search some ingredient",
              hintStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.black))),
          style: TextStyle(color: Colors.black),
        ));
  }
}

class Lista extends StatelessWidget {
  const Lista({super.key});

  @override
  Widget build(BuildContext context) {
    List<Recipe> lista = context.watch<utils.ListState>().getLista();
    var ver = context.watch<utils.ListState>().cancelClicked;
    return Visibility(
      visible: !ver,
      child: Expanded(
          child: ListView.builder(
              key: const ValueKey('listview'),
              padding: EdgeInsets.only(top: 15, bottom: 15),
              itemCount: lista.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 6,
                  margin: const EdgeInsets.all(5),
                  child: ListTile(
                      key: ValueKey("recipe"+index.toString()),
                      onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return description.Description(
                                recipe: lista[index]);
                          })),
                      leading: Container(
                          child: Image.network(
                              lista[index].thumbnail.toString(),
                              fit: BoxFit.cover)),
                      title: Text(lista[index].label.toString()),
                      tileColor: color60),
                );
              })),
    );
  }
}

class Filtro extends StatelessWidget {
  const Filtro({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color60,
          border: Border.all(color: color10),
          borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(top: 10),
      child: DropdownButton(
        key: const ValueKey('dropdown'),
        value: context.watch<utils.FormState>().getFilterDropDown().first,
        enableFeedback: true,
        dropdownColor: color60,
        isExpanded: true,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: color10,
        ),
        iconSize: 42,
        underline: SizedBox(),
        style: const TextStyle(color: Colors.black),
        onChanged: (value) {
          context.read<utils.Condiciones>().setPrevUnsensitive(true);
          context.read<utils.Condiciones>().setNextUnsensitive(true);
          context.read<utils.FormState>().changeFirst(value!);
        },
        items: context
            .watch<utils.FormState>()
            .getFilterDropDown()
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Center(
              child: Text(
                value,
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
