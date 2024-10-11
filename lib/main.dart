import 'package:calc/components/components.dart';
import 'package:calc/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyCalculator(),
    ),
  );
}

class MyCalculator extends StatelessWidget {
  const MyCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, ThemeProvider, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: Colors.white,
              secondaryHeaderColor: const Color(0xff3D6063),
              scaffoldBackgroundColor: Colors.white,
              textTheme: TextTheme(
                bodyMedium: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontFamily: 'GT_Sectra',
                    fontWeight: FontWeight.w900),
                bodySmall: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontFamily: 'GT_Sectra',
                    fontWeight: FontWeight.w600),
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Color(0xff3D6063),
              secondaryHeaderColor: Colors.white,
              scaffoldBackgroundColor: Color(0xff6F9395),
              textTheme: TextTheme(
                bodyMedium: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontFamily: 'GT_Sectra',
                    fontWeight: FontWeight.w900),
                bodySmall: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontFamily: 'GT_Sectra',
                    fontWeight: FontWeight.w600),
              ),
            ),
            themeMode: ThemeProvider.themeMode,
            home: HomePage());
      },
    );
  }
}
