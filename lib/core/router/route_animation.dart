import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class WDXRouteAnimation {
  final Widget child;

  final PageTransitionType type;

  final Curve curve;

  final Alignment alignment;

  final Duration duration;

  final BuildContext ctx;

  final bool inheritTheme;

  WDXRouteAnimation.push(BuildContext context, {
    Key key,
    @required this.child,
    this.type = PageTransitionType.rightToLeft,
    this.ctx,
    this.inheritTheme = false,
    this.curve = Curves.linear,
    this.alignment,
    this.duration = const Duration(milliseconds: 300),
    RouteSettings settings,
  }) {
    Navigator.push(
      context,
      PageTransition(
        child: child,
        type: type,
        inheritTheme: inheritTheme,
        curve: curve,
        alignment: alignment,
        duration: duration,
      ),
    );
  }
}