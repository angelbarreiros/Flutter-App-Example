import 'package:edaman_app/Pantallas/Horizontal/hrecip.dart';
import 'package:edaman_app/Pantallas/Vertical/formlist.dart';
import 'package:edaman_app/edamam.dart';
import 'package:edaman_app/main.dart' as utils;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Horizontal extends StatelessWidget {
  final String title;

  Horizontal({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Tablet());
  }
}

//MediaQuery.of(context).size.width/2
class Tablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Recipe recipe = context.watch<utils.AditionalVariablesHorizontal>().recipe;
    return Container(
        color: color60,
        padding: EdgeInsets.only(top: 20, left: 10),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2.5,
              child: Column(
                children: [
                  Busqueda(),
                  Filtro(),
                  Row(
                    children: [Expanded(child: SearchButton())],
                  ),
                  Spinner(),
                  FormatError(),
                  SearchError(),
                  ListaHorizontal(),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: PrevPage()),
                            Expanded(child: NextPage())
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              height: MediaQuery.of(context).size.height / 1.1,
              width: MediaQuery.of(context).size.width * 0.58,
              child: ListView(
                children: [HDescription(recipe: recipe)],
              ),
            )
          ],
        ));
  }
}

class ListaHorizontal extends StatelessWidget {
  const ListaHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    List<Recipe> lista = context.watch<utils.ListState>().getLista();
    var ver = context.watch<utils.ListState>().cancelClicked;
    return Visibility(
      visible: !ver,
      child: Expanded(
          child: ListView.builder(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              itemCount: lista.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 6,
                  margin: const EdgeInsets.all(5),
                  child: ListTile(
                    onTap: () {
                      context
                          .read<utils.AditionalVariablesHorizontal>()
                          .setRecipe(lista[index]);
                    },
                    leading: Container(
                        child: Image.network(lista[index].thumbnail.toString(),
                            fit: BoxFit.cover)),
                    title: Text(lista[index].label.toString()),
                    tileColor: color60,
                  ),
                );
              })),
    );
  }
}
