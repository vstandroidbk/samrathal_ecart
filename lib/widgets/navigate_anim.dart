import 'package:flutter/material.dart';

class FadeAnimatingRoute extends PageRouteBuilder {
  final Widget? page;
  final Widget route;

  FadeAnimatingRoute({this.page, required this.route})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              page!,
          transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) =>
              FadeTransition(
            opacity: animation,
            child: route,
          ),
        );
}

class SizeAnimatingRoute extends PageRouteBuilder {
  final Widget page;

  SizeAnimatingRoute({required this.page})
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                page,
            transitionDuration: (const Duration(milliseconds: 1000)),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.fastLinearToSlowEaseIn);
              return Align(
                alignment: Alignment.bottomCenter,
                child: SizeTransition(
                  sizeFactor: animation,
                  axisAlignment: 0,
                  child: page,
                ),
              );
            });
}

class ScaleAnimatingRoute extends PageRouteBuilder {
  final Widget page;

  ScaleAnimatingRoute({required this.page})
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                page,
            transitionDuration: (const Duration(milliseconds: 1000)),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.fastLinearToSlowEaseIn);
              return Align(
                alignment: Alignment.bottomCenter,
                child: ScaleTransition(
                  scale: animation,
                  child: page,
                ),
              );
            });
}

class SlideAnimationRoute extends PageRouteBuilder {
  final Widget page;
  final Widget route;

  SlideAnimationRoute({required this.page, required this.route})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              page,
          transitionDuration: (const Duration(milliseconds: 400)),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn);
            return SlideTransition(
              position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: const Offset(0.0, 0.0))
                  .animate(animation),
              child: route,
            );
          },
        );
}
