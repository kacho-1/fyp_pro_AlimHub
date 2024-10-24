import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/Customs/CustomColor.dart';
import 'package:fyp_pro/publicdashboard/Customs/CustomCurveEdges.dart';
import 'CustomAppbar.dart';
class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return  TCurveEdgeWiget(
      child: Container(
        color: TColors.primary,
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [

            Positioned(top: 150, right: -250,
                child: TCircularContainer()),
            Positioned(top: 100, right: -300,
                child: TCircularContainer()),

            child,

          ],
        ),
      ),

    );
  }
}

class TCurveEdgeWiget extends StatelessWidget {
  const TCurveEdgeWiget({
    super.key, this.child

  });
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomCurveEdge(),
      child: child,
    );
  }
}
class TCircularContainer extends StatelessWidget {
  const TCircularContainer({
    super.key,
    this.child,
    this.width = 400,
    this.height= 400,
    this.radius = 400,
    this.padding = 0,
    this.backgroudColor = Colors.grey
  });
  final double? width;
  final double? height;
  final double radius;
  final double padding;
  final Widget? child;
  final Color backgroudColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 400,
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(400),
        color: TColors.textWhite.withOpacity(0.1),

      ),
      child: child,
    );
  }
}