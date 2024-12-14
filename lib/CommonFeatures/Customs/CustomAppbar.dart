import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'CustomColor.dart';
class CAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CAppBar ({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false,
  });
   final Widget? title;
   final bool showBackArrow;
   final IconData? leadingIcon;
   final List<Widget>? actions;
   final VoidCallback? leadingOnPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal:16 ),
    child: AppBar(
    backgroundColor: TColors.primary,


    automaticallyImplyLeading: false,
    leading: showBackArrow?
         IconButton(onPressed: () =>Get.back(), icon: const Icon(Icons.arrow_back_outlined))
        :leadingIcon !=null? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon)) :null,
    title: title,
    actions: actions,


    ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(24.0);
}
