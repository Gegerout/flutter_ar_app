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
    // return Card(
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    //   margin: EdgeInsets.zero,
    //   child: InkWell(
    //     onTap: () => item.onTap(),
    //     child: ListTile(
    //       leading: Icon(item.icon),
    //       title: Text(
    //         item.title,
    //         style: Theme.of(context).textTheme.titleMedium,
    //       ),
    //       subtitle: Text(
    //         item.description,
    //         style: Theme.of(context).textTheme.titleSmall,
    //         overflow: TextOverflow.ellipsis,
    //       ),
    //     ),
    //   ),
    // );
    return Row(
      children: [
        SizedBox(
          width: 70,
          height: 70,
          child: Card(
            child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => item.onTap(),
                child: Icon(
                  item.icon,
                  size: 34,
                )),
          ),
        ),
        SizedBox(
          height: 70,
          child: Card(
            child: InkWell(
              onTap: () => item.onTap(),
              child: SizedBox(
                width: 300,
                child: ListTile(
                  title: Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    item.description,
                    style: Theme.of(context).textTheme.titleSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
