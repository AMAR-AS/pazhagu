
// lib/widgets/styled_container.dart

import 'package:flutter/material.dart';
import 'package:pazhagu/providers/settings_provider.dart';
import 'package:pazhagu/styles/glassmorphism/glass_ui.dart';
import 'package:pazhagu/styles/liquidity/liquid_ui.dart';
import 'package:pazhagu/styles/neumorphism/neumorphic_ui.dart';
import 'package:provider/provider.dart';

class StyledContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;


  const StyledContainer({
    Key? key,
    required this.child,
    this.margin,
    this.padding,
    this.borderRadius,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, _) {
        switch (settingsProvider.themeStyle) {
          case ThemeStyle.glassmorphism:
            return GlassUI(
              margin: margin,
              padding: padding ?? const EdgeInsets.all(12),
              borderRadius: borderRadius,
              onTap: onTap,
              child: child,
            );
          case ThemeStyle.liquid:
            return GestureDetector(
              onTap: onTap,
              child: Container(
                margin: margin,
                padding: padding ?? const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: borderRadius ?? BorderRadius.circular(16),
                ),
                child: child,
              ),
            );
          case ThemeStyle.neumorphism:
            return GestureDetector(
              onTap: onTap,
              child: Container(
                margin: margin,
                padding: padding ?? const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: borderRadius ?? BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(4, 4),
                      blurRadius: 10,
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.7),
                      offset: const Offset(-4, -4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: child,
              ),
            );
        }
      },
    );
  }
}
