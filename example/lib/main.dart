import 'package:example/employee_submitted.dart';
import 'package:example/example/filter.dart';
import 'package:example/example/form_employee.dart';
import 'package:example/example/model/city.dart';
import 'package:example/example/model/country.dart';
import 'package:example/example/model/employee.dart';
import 'package:example/example/model/province.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Form Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Dynamic Form Example Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FormEmployee form = FormEmployee(
      employee: Employee(
          name: "Bernardo",
          password: "",
          country: Country(2, "Brasil"),
          province: Province(4, "San Pablo", 2),
          city: City(9, "San Pablo 1", 4)),
      onSubmit: (context, Employee emp) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return EmployeeSubmitted(employee: emp);
        }));
      },
      onCancel: (context) {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(child: Filter()),// form.draw(context)),
    );
  }
}
