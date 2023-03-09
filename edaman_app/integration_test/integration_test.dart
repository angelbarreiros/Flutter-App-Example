import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test/integration_test_driver.dart';
import 'package:edaman_app/main.dart' as app;


void main() {

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Existencia de todos los widgets al empezar la aplicación",
          (tester) async {
        app.main();
        await tester.pumpAndSettle();

        final message = find.byType(TextField);
        expect(message, findsOneWidget);

        final list = find.byType(ListView);
        expect(list, findsOneWidget);

        final dropdown = find.byKey(const ValueKey('dropdown'));
        expect(dropdown, findsOneWidget);

        final search = find.text("Search");
        expect(search, findsOneWidget);

        final next = find.text("Next page");
        expect(next, findsOneWidget);

        final cancel = find.text("Cancel");
        expect(cancel, findsOneWidget);


        final previous = find.text("Previous");
        expect(previous, findsOneWidget);

      });

  testWidgets('Buscar una receta y elegirla', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);

    await tester.enterText(textField, 'tomato');

    final dropdown = find.byKey(const ValueKey('dropdown'));
    expect(dropdown, findsOneWidget);

    await tester.tap(dropdown);
    await tester.pumpAndSettle();

    final dropdownItem = find.text("Alcohol-cocktail").last;
    expect(dropdownItem, findsOneWidget);

    await tester.tap(dropdownItem);
    await tester.pumpAndSettle();

    final button = find.text("Search");
    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    final scrollableListview = find.descendant(
      of: find.byType(ListView).first,
      matching: find.byType(Scrollable),
    );
    expect(scrollableListview, findsOneWidget);

    //o value key é o mismo que puxeches no exemplo , deberia devolver
    //a 10 receta
    final lastItem = find.byKey(const ValueKey("recipe16"));
    await tester.scrollUntilVisible(
      lastItem,
      500.0,
      scrollable: scrollableListview,
    );
    expect(lastItem, findsOneWidget);


    await tester.tap(lastItem);
    await tester.pumpAndSettle();




  });


  testWidgets('Buscar una receta y ir hacia delante hacia atras y encontrar receta', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);

    await tester.enterText(textField, 'tomato');

    final dropdown = find.byKey(const ValueKey('dropdown'));
    expect(dropdown, findsOneWidget);

    await tester.tap(dropdown);
    await tester.pumpAndSettle();

    final dropdownItem = find
        .text("Alcohol-cocktail")
        .last;
    expect(dropdownItem, findsOneWidget);

    final scrollableListview = find.descendant(
      of: find.byType(ListView).first,
      matching: find.byType(Scrollable),
    );
    expect(scrollableListview, findsOneWidget);

    await tester.tap(dropdownItem);
    await tester.pumpAndSettle();

    final search = find.text("Search");
    expect(search, findsOneWidget);

    final previous = find.text("Previous");
    expect(previous, findsOneWidget);

    await tester.tap(search);
    await tester.pumpAndSettle();

    final next = find.text("Next page");
    expect(next, findsOneWidget);

    await tester.tap(next);
    await tester.pumpAndSettle();

    await tester.tap(next);
    await tester.pumpAndSettle();

    await tester.tap(previous);
    await tester.pumpAndSettle();

    final lastItem = find.byKey(const ValueKey("recipe16"));
    await tester.scrollUntilVisible(
      lastItem,
      500.0,
      scrollable: scrollableListview,
    );
    expect(lastItem, findsOneWidget);

    await tester.tap(lastItem);
    await tester.pumpAndSettle();


    final titulo= find.text("Vodka Cream Sauce Recipe");
    expect(titulo, findsOneWidget);





  });


  testWidgets('encontrar las especificaciones y las expand tiles de las descripcciones', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);

    await tester.enterText(textField, 'tomato');

    final dropdown = find.byKey(const ValueKey('dropdown'));
    expect(dropdown, findsOneWidget);

    await tester.tap(dropdown);
    await tester.pumpAndSettle();

    final dropdownItem = find.text("Alcohol-cocktail").last;
    expect(dropdownItem, findsOneWidget);

    await tester.tap(dropdownItem);
    await tester.pumpAndSettle();

    final button = find.text("Search");
    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    final scrollableListview = find.descendant(
      of: find.byType(ListView).first,
      matching: find.byType(Scrollable),
    );
    expect(scrollableListview, findsOneWidget);

    final lastItem = find.byKey(const ValueKey("recipe10"));
    await tester.scrollUntilVisible(
      lastItem,
      500.0,
      scrollable: scrollableListview,
    );
    expect(lastItem, findsOneWidget);


    await tester.tap(lastItem);
    await tester.pumpAndSettle();

    final secondlistview = find.descendant(
      of: find.byType(ListView),
      matching: find.byType(Scrollable),
    );
    expect(secondlistview, findsOneWidget);

    final servings = find.text("Nº of servings: ");
    expect(servings, findsOneWidget);
    final calories = find.text("Nº of calories: ");
    expect(calories, findsOneWidget);
    final expandtile = find.byType(ExpansionTile);
    expect(expandtile, findsWidgets);

    await tester.tap(expandtile.first);
    await tester.pumpAndSettle();


    final tile = find.text("world");
    expect(tile, findsOneWidget);

    await tester.tap(expandtile.first);
    await tester.pumpAndSettle();

    final textbutton = find.byKey(ValueKey("nutrients"));

    await tester.scrollUntilVisible(
      textbutton,
      500.0,
      scrollable: secondlistview,
    );
    expect(textbutton, findsOneWidget);


    await tester.tap(textbutton);
    await tester.pumpAndSettle();

    final thirdlistview = find.descendant(
      of: find.byType(ListView),
      matching: find.byType(Scrollable),
    );
    expect(thirdlistview, findsOneWidget);

    final energy = find.byKey(ValueKey("Vitamin B12"));
    await tester.scrollUntilVisible(
      energy,
      500.0,
      scrollable: thirdlistview,
    );
    expect(energy, findsOneWidget);




  });
  testWidgets('error invalid search', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);

    await tester.enterText(textField, 'xddddd');

    final dropdown = find.byKey(const ValueKey('dropdown'));
    expect(dropdown, findsOneWidget);

    await tester.tap(dropdown);
    await tester.pumpAndSettle();

    final dropdownItem = find.text("Alcohol-cocktail").last;
    expect(dropdownItem, findsOneWidget);

    await tester.tap(dropdownItem);
    await tester.pumpAndSettle();

    final button = find.text("Search");
    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    final image=find.image(const AssetImage("assets/err_brequest.jpg"));
    expect(image, findsOneWidget);
  });

  testWidgets('error no matches found', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);

    await tester.enterText(textField, 'tuna');

    final dropdown = find.byKey(const ValueKey('dropdown'));
    expect(dropdown, findsOneWidget);

    await tester.tap(dropdown);
    await tester.pumpAndSettle();

    final dropdownItem = find.text("Alcohol-cocktail").last;
    expect(dropdownItem, findsOneWidget);

    await tester.tap(dropdownItem);
    await tester.pumpAndSettle();

    final button = find.text("Search");
    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    final image=find.image(const AssetImage("assets/err_nfound.jpg"));
    expect(image, findsOneWidget);


  });

}
