import 'package:fiona_dynamic_form/src/model/form_select_item.dart';
import 'package:example/example/model/country.dart';
import 'package:example/example/model/province.dart';


class ProvinceController extends FormSelectFieldController{

  late List<Province> states;

  ProvinceController(){
    states = List<Province>.empty(growable: true);
    states.add(Province(0, "- Select an state -",0));
    states.add(Province(1, "Buenos",1));
    states.add(Province(2, "Córdoba",1));
    states.add(Province(3, "Santa Fé",1));
    states.add(Province(4, "San Pablo",2));
  }

  @override
  Future<List> findItems(String text) async{
    int countryId = 0;
    if(filter!=null){
      countryId = (filter as Country).id;
    }

    return states.where((element) => (element.countryId==countryId || element.countryId==0) && element.name.startsWith(text)).toList(growable: true);
  }

  @override
  String getItemLabel(item) {
    return (item as Province).name;
  }

  @override
  int getItemId(item) {
    return (item as Province).id;
  }


}