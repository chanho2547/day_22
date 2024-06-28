import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavTab extends StatelessWidget {
  const NavTab({
    super.key,
    required this.onTap,
    required this.isSeleted,
    required this.icon,
  });

  final Function onTap;
  final bool isSeleted;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: AnimatedOpacity(
          opacity: isSeleted ? 1 : 0.4,
          duration: const Duration(milliseconds: 300),
          child: Center(
            child: FaIcon(
              icon,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
