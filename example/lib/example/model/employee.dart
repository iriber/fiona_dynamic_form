import 'package:example/example/model/city.dart';
import 'package:example/example/model/country.dart';
import 'package:example/example/model/province.dart';
import 'package:uuid/uuid.dart';

class Employee {
  late final String id;
  String name;
  String? email;
  String password;
  DateTime? birthday;
  int? employeeSinceYear;
  City? city;
  Province? province;
  Country? country;
  bool? rememberMe;
  DateTime? lastPost;
  DateTime? startTime;
  double? salary;
  double? number;

  Employee(
      {required this.name,
      required this.password,
      this.email,
      this.employeeSinceYear,
      this.birthday,
      this.city,
      this.province,
      this.country,
      this.rememberMe,
      this.lastPost,
      this.startTime,
      this.salary,
      this.number}) {
    id = const Uuid().v4();
  }
}
