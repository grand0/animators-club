import 'package:flutter/material.dart';

import '../theme.dart' as theme;

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    required this.name,
    required this.url,
    this.size = 32,
  }) : super(key: key);

  final String name;
  final String? url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: theme.mainColor,
      radius: size,
      foregroundImage: url != null ? Image.network(url!).image : null,
      child: Text(
        name[0],
        style: TextStyle(color: Colors.white, fontSize: size * 0.75),
      ),
    );
  }
}
