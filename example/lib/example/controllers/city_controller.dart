import 'package:fiona_dynamic_form/src/model/form_select_item.dart';
import 'package:example/example/model/city.dart';
import 'package:example/example/model/province.dart';

class CityController extends FormSelectFieldController{

  late List<City> cities;

  CityController(){
    cities = List<City>.empty(growable: true);
    cities.add(City(0, "- Select a city -",0));
    cities.add(City(1, "Azul",1));
    cities.add(City(2, "Buenos Aires",1));
    cities.add(City(3, "Olavarría",1));
    cities.add(City(4, "Tandil",1));
    cities.add(City(5, "Rio Cuarto",2));
    cities.add(City(6, "Villa Gral. Belgrano",2));
    cities.add(City(7, "Rosario",3));
    cities.add(City(8, "Santa Fé",3));
    cities.add(City(9, "San Pablo 1",4));
    cities.add(City(10, "San Pablo 2",4));
  }

  @override
  Future<List> findItems(String text) async{
    int stateId = 0;
    if(filter!=null){
      stateId = (filter as Province).id;
    }
    return cities.where((element) => ( (element.stateId==stateId || element.stateId==0) &&  element.name.startsWith(text))).toList(growable: true);
  }

  @override
  String getItemLabel(item) {
    return (item as City).name;
  }

  @override
  int getItemId(item) {
    return (item as City).id;
  }


}
