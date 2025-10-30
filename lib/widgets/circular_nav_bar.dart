
// lib/widgets/circular_nav_bar.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pazhagu/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class CircularNavBar extends StatefulWidget {
  const CircularNavBar({Key? key}) : super(key: key);

  @override
  _CircularNavBarState createState() => _CircularNavBarState();
}

class _CircularNavBarState extends State<CircularNavBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _angle = 0;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, _) {
        final visibleItems = settingsProvider.navItemOrder
            .where((item) => settingsProvider.navItemVisibility[item]!)
            .toList();

        return SizedBox(
          height: 100,
          width: double.infinity,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _angle += details.delta.dx / 100;
              });
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: List.generate(visibleItems.length, (index) {
                final itemAngle = _angle + (index / visibleItems.length) * 2 * pi;
                final isVisible = (itemAngle % (2 * pi) - pi).abs() < pi / 2;
                if (!isVisible) {
                  return const SizedBox.shrink();
                }
                final isSelected = _selectedIndex == index;

                return Transform.translate(
                  offset: Offset(
                    120 * cos(itemAngle - pi / 2),
                    -30 + 120 * sin(itemAngle - pi / 2),
                  ),
                  child: isSelected
                      ? ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(_getIcons(visibleItems)[visibleItems[index]]),
                          label: Text(visibleItems[index].toString().split('.').last),
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          icon: Icon(_getIcons(visibleItems)[visibleItems[index]]),
                        ),
                );
              }),
            ),
          ),
        );
      },
    );
  }

  Map<NavItem, IconData> _getIcons(List<NavItem> visibleItems) {
    final Map<NavItem, IconData> icons = {};
    for (var item in visibleItems) {
      switch (item) {
        case NavItem.home:
          icons[item] = Icons.home;
          break;
        case NavItem.moments:
          icons[item] = Icons.collections;
          break;
        case NavItem.media:
          icons[item] = Icons.image;
          break;
        case NavItem.room:
          icons[item] = Icons.videocam;
          break;
        case NavItem.calendar:
          icons[item] = Icons.calendar_today;
          break;
        case NavItem.profile:
          icons[item] = Icons.person;
          break;
        case NavItem.map:
          icons[item] = Icons.map;
          break;
        case NavItem.updates:
          icons[item] = Icons.whatshot;
          break;
      }
    }
    return icons;
  }
}
