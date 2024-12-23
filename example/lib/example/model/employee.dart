import 'package:example/example/model/city.dart';
import 'package:example/example/model/country.dart';
import 'package:example/example/model/province.dart';
import 'package:uuid/uuid.dart';

class Employee {

  late final String id;
  String name;
  String password;
  City? city;
  Province? province;
  Country? country;
  bool? rememberMe;

  Employee({required this.name, required this.password, this.city, this.province, this.country, this.rememberMe}){
    id = const Uuid().v4();
  }

}

