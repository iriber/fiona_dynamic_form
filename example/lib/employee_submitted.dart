import 'package:example/example/model/employee.dart';
import 'package:flutter/material.dart';

class EmployeeSubmitted extends StatelessWidget {
  final Employee employee;

  const EmployeeSubmitted({super.key, required this.employee});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Form Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: body(context),
    );
  }

  Widget body(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Submitted Employee"),
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Name: ${employee.name} "),
                Text("Password: ${employee.password} "),
                Text("Email: ${employee.email} "),
                Text("Since year: ${employee.employeeSinceYear} "),
                Text("Salary: ${employee.salary} "),
                Text("Number: ${employee.number} "),
                Text("Percentage: ${employee.percentage} "),
                Text("Birthday: ${employee.birthday} "),
                Text("Last Post: ${employee.lastPost} "),
                Text("Start Time: ${employee.startTime} "),
                Text("RememberMe: ${employee.rememberMe} "),
                Text("City: ${employee.city?.name} "),
                Text("State: ${employee.province?.name} "),
                Text("Country: ${employee.country?.name} "),
                const Divider(height: 20),
                ElevatedButton(
                  child: const Text("Close", textAlign: TextAlign.center),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            )));
  }
}
