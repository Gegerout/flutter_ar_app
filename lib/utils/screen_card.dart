import 'package:flutter/material.dart';
import '../models/screen_model.dart';

class ScreenCard extends StatelessWidget {
  const ScreenCard({
    required this.item,
    Key? key,
  }) : super(key: key);
  final ScreenModel item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => item.onTap(),
        child: ListTile(
          leading: Icon(item.icon),
          title: Text(
            item.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
            item.description,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}