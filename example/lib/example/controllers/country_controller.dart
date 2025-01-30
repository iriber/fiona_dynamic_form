import 'package:fiona_dynamic_form/src/model/form_select_item.dart';
import 'package:example/example/model/country.dart';

class CountryController extends FormSelectFieldController {
  late List<Country> countries;

  CountryController() {
    countries = List<Country>.empty(growable: true);
    countries.add(Country(1, "Argentina"));
    countries.add(Country(2, "Brasil"));
  }

  @override
  Future<List> findItems(String text) async {
    return countries
        .where((element) => element.name.startsWith(text))
        .toList(growable: true);
  }

  @override
  String getItemLabel(item) {
    return (item as Country).name;
  }

  @override
  int getItemId(item) {
    return (item as Country).id;
  }
  @override
  buildItem(int id, String label) {
    return Country(id, label);
  }
}
