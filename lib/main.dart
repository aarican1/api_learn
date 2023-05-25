import 'package:flutter/material.dart';
import 'package:flutter_api_learn/view/checkIntView.dart';
import 'package:flutter_api_learn/view/empty_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final String title = 'Api Learning';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: title,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          useMaterial3: true,
        ),
        builder: (context, child) {
          return Column(
            children: [
              CheckIntView(),
              Expanded(child: child ?? Placeholder()),
            ],
          );
        },
        home: EmptyPage());
  }
}
