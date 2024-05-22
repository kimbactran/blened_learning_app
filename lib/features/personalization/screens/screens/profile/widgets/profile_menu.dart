import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LProfileMenu extends StatelessWidget {
  const LProfileMenu({
    super.key,
    this.icon = Iconsax.arrow_right_34,
    required this.onPressed,
    required this.title,
    required this.value, this.showIcon = true,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String title, value;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            )),
        Expanded(
          flex: 5,
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if(showIcon)
        Icon(icon, size: 18),
      ],
    );
  }
}
