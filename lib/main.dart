import 'package:day_22/features/home/views/nav_screen.dart';
import 'package:day_22/features/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      // 전체 앱의 테마
      theme: ThemeData(
        // 전체 스캐폴드의 배경색을 지정
        scaffoldBackgroundColor: Colors.white,

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
        ),

        // 전체 바텀 앱바의 테마를 지정
        bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    );
  }
}
