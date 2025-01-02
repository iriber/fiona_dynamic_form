import 'package:example/example/model/city.dart';
import 'package:example/example/model/country.dart';
import 'package:example/example/model/province.dart';
import 'package:uuid/uuid.dart';

class Employee {
  late final String id;
  String name;
  String password;
  DateTime? birthday;
  City? city;
  Province? province;
  Country? country;
  bool? rememberMe;
  DateTime? lastPost;

  Employee(
      {required this.name,
      required this.password,
      this.birthday,
      this.city,
      this.province,
      this.country,
      this.rememberMe,
      this.lastPost}) {
    id = const Uuid().v4();
  }
}
