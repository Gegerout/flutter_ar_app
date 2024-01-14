import 'package:ar_app/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Flutter AR App',
      // theme: ThemeData(
      //   useMaterial3: true,
      //   colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF2C00))
      // ),
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFFFF2C00),
      ),
      home: HomeScreen(),
    );
  }
}
