import 'package:flutter/material.dart';
import 'package:share_your_expenses/enums/category.dart';
import 'package:share_your_expenses/models/group.dart';
import 'package:share_your_expenses/screens/expenses_screen.dart';
import 'package:share_your_expenses/services/firestore_service.dart';

class GroupItem extends StatelessWidget {
  GroupItem({
    Key? key,
    required this.animation,
    required this.group,
  }) : super(key: key);

  final FirestoreService _firestoreService = FirestoreService.instance;

  final Group group;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Group>(
      stream: _firestoreService.getGroup(group.id!),
      builder: (context, AsyncSnapshot<Group> snapshot) {
        Group newGroup = group;

        if (snapshot.hasData) {
          newGroup = snapshot.data!;
        }

        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: const Offset(0, 0),
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.bounceIn,
              reverseCurve: Curves.bounceOut,
            ),
          ),
          child: GestureDetector(
            child: ListTile(
              contentPadding: const EdgeInsets.all(15),
              title: Text(
                newGroup.name,
                style: Theme.of(context).textTheme.headline5,
              ),
              subtitle: Text(
                newGroup.description,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              leading: Icon(
                group.category != null ? group.category!.iconData : Icons.alarm,
                size: 40,
                color: Colors.blueGrey,
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExpensesScreen(
                    groupId: group.id!,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
