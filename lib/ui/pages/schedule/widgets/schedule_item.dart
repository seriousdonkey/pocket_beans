import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pocket_beans/domain/entities/schedule_entry.dart';

class ScheduleItem extends StatelessWidget {
  final ScheduleEntry item;

  const ScheduleItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final Widget icon;
    if (item.type == ScheduleType.gameplay) {
      icon = const FaIcon(FontAwesomeIcons.gamepad);
    } else if (item.type == ScheduleType.justChatting) {
      icon = const FaIcon(FontAwesomeIcons.comments);
    } else {
      icon = const FaIcon(FontAwesomeIcons.youtube);
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListTile(
        tileColor: Colors.grey.shade900,
        leading: IconButton(
          onPressed: () {},
          icon: icon,
        ),
        title: Text(item.title),
        subtitle: Text(item.game ?? ''),
        trailing: Text(DateFormat.jm().format(item.timeStart)),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
