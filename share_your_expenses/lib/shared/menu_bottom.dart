import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuBottom extends StatefulWidget {
  const MenuBottom({
    Key? key,
    required this.selected,
  }) : super(key: key);

  final int selected;
  @override
  State<MenuBottom> createState() => _MenuBottomState();
}

class _MenuBottomState extends State<MenuBottom> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.brown.shade300,
        selectedItemColor: Colors.brown.shade800,
        onTap: (int index) {
          setState(() {});
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/groups');
              break;
            case 1:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
        currentIndex: widget.selected,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: l10n!.groups,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: l10n.profile,
          ),
        ]);
  }
}
