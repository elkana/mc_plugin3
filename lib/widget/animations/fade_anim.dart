import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum AniProps { opacity, translateY, translateX }

// https://github.com/felixblaschke/simple_animations/blob/main/example/example.md#animation-mixin
// https://pub.dev/packages/simple_animations
// mmigrate to flutter 3, https://stackoverflow.com/questions/62398085/fadeanimation-code-errors-while-trying-to-update-simple-animations-2-2-1-after/64085688#64085688
class LogoAnimation extends StatelessWidget {
  final double delay;
  final Widget child;
  final VoidCallback onCompleted;

  const LogoAnimation(this.delay, {super.key, required this.child, required this.onCompleted});

  // @override
  // Widget build(BuildContext context) {
  //   final tween = MultiTween<AniProps>()
  //     ..add(AniProps.opacity, Tween(begin: 0.0, end: 1.0))
  //     // ..add(AniProps.translateX, Tween(begin: -130.0, end: 0.0), const Duration(milliseconds: 500), Curves.easeOut)
  //     ..add(AniProps.translateY, Tween(begin: -100.0, end: 0.0), const Duration(milliseconds: 1000), Curves.bounceOut);

  //   return PlayAnimation<MultiTweenValues<AniProps>>(
  //       delay: Duration(milliseconds: (500 * delay).round()),
  //       duration: tween.duration,
  //       tween: tween,
  //       child: child,
  //       builder: (context, child, animation) => Opacity(
  //           opacity: animation.get(AniProps.opacity),
  //           child: Transform.translate(offset: Offset(0, animation.get(AniProps.translateY)), child: child)));
  // }

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween('opacity', Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1500), curve: Curves.easeIn)
      ..tween(
          'translateY',
          duration: const Duration(milliseconds: 2000),
          Tween(begin: 100.0, end: 0.0),
          curve: Curves.bounceOut);

    return CustomAnimationBuilder(
        delay: Duration(milliseconds: (500 * delay).round()),
        duration: tween.duration,
        tween: tween,
        animationStatusListener: (status) {
          if (status == AnimationStatus.completed) {
            // do another...
            onCompleted();
          }
        },
        child: child,
        builder: (BuildContext context, Movie value, Widget? child) {
          return Opacity(
              opacity: value.get("opacity"),
              child: Transform.translate(offset: Offset(0.0, value.get("translateY")), child: child));
        });
  }
}

class FadeTopDownAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeTopDownAnimation(this.delay, {super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween('opacity', Tween(begin: 0.0, end: 1.0), duration: const Duration(milliseconds: 500), curve: Curves.easeIn)
      ..tween(
          'translateY',
          duration: const Duration(milliseconds: 500),
          Tween(begin: -30.0, end: 0.0),
          curve: Curves.easeOut);

    return CustomAnimationBuilder(
        delay: Duration(milliseconds: (500 * delay).round()),
        duration: tween.duration,
        tween: tween,
        child: child,
        builder: (BuildContext context, Movie value, Widget? child) {
          return Opacity(
              opacity: value.get("opacity"),
              child: Transform.translate(offset: Offset(0.0, value.get("translateY")), child: child));
        });
  }
}

// https://pub.dev/packages/simple_animations
class FadeDownTopAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeDownTopAnimation(this.delay, {super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween('opacity', Tween(begin: 0.0, end: 1.0), duration: const Duration(milliseconds: 500), curve: Curves.easeIn)
      ..tween(
          'translateY',
          duration: const Duration(milliseconds: 500),
          Tween(begin: 30.0, end: 0.0),
          curve: Curves.easeOut);

    return CustomAnimationBuilder(
        delay: Duration(milliseconds: (500 * delay).round()),
        duration: tween.duration,
        tween: tween,
        child: child,
        builder: (BuildContext context, Movie value, Widget? child) {
          return Opacity(
              opacity: value.get("opacity"),
              child: Transform.translate(offset: Offset(0.0, value.get("translateY")), child: child));
        });
  }
}

extension AnimationExtension on Widget {
  Widget fadeTopDownAnim(double delay) => FadeTopDownAnimation(delay, child: this);
  Widget fadeDownTopAnim(double delay) => FadeDownTopAnimation(delay, child: this);
}
