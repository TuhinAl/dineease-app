import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? color;
  final double? elevation;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.elevation,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidget = Card(
      elevation: elevation ?? AppSpacing.elevationMedium,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(AppSpacing.spacingLarge),
        child: child,
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        child: cardWidget,
      );
    }

    return cardWidget;
  }
}
