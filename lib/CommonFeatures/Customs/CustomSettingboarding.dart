import 'package:flutter/material.dart';

import 'CustomColor.dart';


class TSettingBody extends StatelessWidget {
  const TSettingBody({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.traling,
    this.onTap,
  });
  final IconData icon;
  final String title, subtitle;
  final Widget? traling;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,size: 28,color: TColors.primary,),
      title: Text(title,style: Theme.of(context).textTheme.titleMedium,),
      subtitle: Text(subtitle,style: Theme.of(context).textTheme.labelMedium,),
      trailing: traling,
      onTap: onTap,
    );
  }
}
