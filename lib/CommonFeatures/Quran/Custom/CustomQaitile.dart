import 'package:flutter/material.dart';

import '../Models/QariModel.dart';

class QariCustomTile extends StatefulWidget {
  const QariCustomTile({super.key,required  this.qari,required this.ontap});
  final Qari qari;
  final VoidCallback ontap;
  @override
  State<QariCustomTile> createState() => _QariCustomTileState();
}

class _QariCustomTileState extends State<QariCustomTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  widget.ontap,
      child: Padding(
          padding: const EdgeInsets.all(4),
      child: Container(
       padding: const EdgeInsets.all(20),
       decoration: const BoxDecoration(
         color: Colors.white,
         shape: BoxShape.rectangle,
         borderRadius:  BorderRadius.all(Radius.circular(8)),
         boxShadow: [
           BoxShadow(
             blurRadius: 3,
             spreadRadius: 0,
             offset: Offset(0, 1),
           )
         ]
       ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.qari.name!,textAlign: TextAlign.start,
              style:const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ) ,)
          ],
        ),
      ),),
    );
  }
}
