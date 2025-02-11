import 'package:day_22/features/home/views/main_screen.dart';
import 'package:day_22/features/home/views/nav_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const NavScreen(),
    )
  ],
);
