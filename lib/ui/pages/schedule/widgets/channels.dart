import 'package:flutter/material.dart';

import '../../../../domain/entities/channel.dart';

class Channels extends StatelessWidget {
  const Channels({
    super.key,
    required this.channels,
    required this.onChannelChanged,
    required this.show,
    this.selectedChannel,
  });

  final List<Channel> channels;
  final Channel? selectedChannel;
  final Function onChannelChanged;
  final bool show;

  static const double _selectedAvatarRadius = 40;
  static const double _selectedAvatarImageRadius = 38;

  static const double _avatarRadius = 30;
  static const double _avatarImageRadius = 28;

  @override
  Widget build(BuildContext context) {
    final channelIcons = channels.map(
      (e) => GestureDetector(
        onTap: () {
          onChannelChanged(e);
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: CircleAvatar(
            radius: selectedChannel?.mgmtId == e.mgmtId
                ? _selectedAvatarRadius
                : _avatarRadius,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: selectedChannel?.mgmtId == e.mgmtId
                  ? _selectedAvatarImageRadius
                  : _avatarImageRadius,
              backgroundImage: NetworkImage(e.channelIconUrl),
            ),
          ),
        ),
      ),
    );

    return AnimatedContainer(
      height: show ? 100 : 0,
      duration: const Duration(milliseconds: 200),
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [...channelIcons],
      ),
    );
  }
}
