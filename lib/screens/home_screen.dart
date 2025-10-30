
// ===== SCREENS =====
// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:pazhagu/providers/settings_provider.dart';
import 'package:pazhagu/screens/chat/chats_screen.dart';
import 'package:pazhagu/screens/create_post_screen.dart';
import 'package:pazhagu/screens/link_device.dart';
import 'package:pazhagu/screens/map/map_screen.dart';
import 'package:pazhagu/screens/media/media_screen.dart';
import 'package:pazhagu/screens/moments/moments_screen.dart';
import 'package:pazhagu/screens/notifications/notification_screen.dart';
import 'package:pazhagu/screens/profile/profile_screen.dart';
import 'package:pazhagu/screens/room/room_screen.dart';
import 'package:pazhagu/screens/settings/settings_screen.dart';
import 'package:pazhagu/screens/updates/updates_screen.dart';
import 'package:pazhagu/widgets/circular_nav_bar.dart';
import 'package:pazhagu/widgets/styled_container.dart';
import 'package:provider/provider.dart';
import 'package:pazhagu/providers/mode_provider.dart';
import 'package:pazhagu/providers/theme_provider.dart';
import 'package:pazhagu/widgets/mode_selector.dart';
import 'package:pazhagu/widgets/sidebar_drawer.dart';
import 'package:pazhagu/screens/calendar_screen.dart';
import 'package:pazhagu/screens/qr_code_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isModeSelectorCollapsed = false;

  final Map<NavItem, Widget> _screens = {
    NavItem.home: const ChatsScreen(),
    NavItem.moments: const MomentsScreen(),
    NavItem.media: const MediaScreen(),
    NavItem.room: const RoomScreen(),
    NavItem.calendar: const CalendarScreen(),
    NavItem.profile: const ProfileScreen(),
    NavItem.map: const MapScreen(),
    NavItem.updates: const UpdatesScreen(),
  };

  final Map<NavItem, IconData> _icons = {
    NavItem.home: Icons.home,
    NavItem.moments: Icons.collections,
    NavItem.media: Icons.image,
    NavItem.room: Icons.videocam,
    NavItem.calendar: Icons.calendar_today,
    NavItem.profile: Icons.person,
    NavItem.map: Icons.map,
    NavItem.updates: Icons.whatshot,
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, _) {
        final visibleItems = settingsProvider.navItemOrder
            .where((item) => settingsProvider.navItemVisibility[item]!)
            .toList();

        return Scaffold(
          key: _scaffoldKey,
          extendBody: true, // Important for floating nav bar
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                ),
                IconButton(
                  icon: const Icon(Icons.qr_code),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const QRCodeScreen()),
                    );
                  },
                ),
              ],
            ),
            leadingWidth: 112,
            title: const Text(
              'PAZHAGU',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
            actions: [
              IconButton(
                icon: Consumer<ThemeProvider>(
                  builder: (context, themeProvider, _) =>
                      Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
                ),
                onPressed: () {
                  context.read<ThemeProvider>().toggleTheme();
                },
              ),
              PopupMenuButton(
                onSelected: (value) {
                  if (value == 'link_device') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LinkDeviceScreen()),
                    );
                  } else if (value == 'settings') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingsScreen()),
                    );
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'link_device',
                    child: Row(
                      children: [
                        Icon(Icons.devices),
                        SizedBox(width: 8),
                        Text('Link Device'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'settings',
                    child: Row(
                      children: [
                        Icon(Icons.settings),
                        SizedBox(width: 8),
                        Text('Settings'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'switch_account',
                    child: Row(
                      children: [
                        Icon(Icons.account_circle),
                        SizedBox(width: 8),
                        Text('Switch Account'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          drawer: const SidebarDrawer(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ModeSelector(
                        isCollapsed: _isModeSelectorCollapsed,
                        onCollapseChanged: (isCollapsed) {
                          setState(() {
                            _isModeSelectorCollapsed = isCollapsed;
                          });
                        },
                      ),
                    ),
                    if (!_isModeSelectorCollapsed)
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          setState(() {
                            _isModeSelectorCollapsed = true;
                          });
                        },
                      ),
                    _buildQuickAccessButton(settingsProvider),
                  ],
                ),
              ),
              Expanded(
                child: _screens[visibleItems[_selectedIndex]]!,
              ),
            ],
          ),
          bottomNavigationBar: _buildNavBar(visibleItems, settingsProvider.navBarStyle),
          floatingActionButton: visibleItems.isNotEmpty && visibleItems[_selectedIndex] == NavItem.media
              ? FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CreatePostScreen()),
                    );
                  },
                  label: const Text('Post'),
                  icon: const Icon(Icons.add),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                )
              : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  Widget _buildNavBar(List<NavItem> visibleItems, NavBarStyle style) {
    if (visibleItems.isEmpty) {
      return const SizedBox.shrink(); // Return an empty box if no items are visible
    }

    switch (style) {
      case NavBarStyle.rectangular:
        return _buildFloatingNavBar(visibleItems);
      case NavBarStyle.circular:
        return const CircularNavBar();
      default:
        return _buildFloatingNavBar(visibleItems);
    }
  }

  Widget _buildFloatingNavBar(List<NavItem> visibleItems) {
    return StyledContainer(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      borderRadius: BorderRadius.circular(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: visibleItems.map((item) {
          final int index = visibleItems.indexOf(item);
          return _buildNavItem(item, index);
        }).toList(),
      ),
    );
  }

  Widget _buildNavItem(NavItem item, int index) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: StyledContainer(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        borderRadius: BorderRadius.circular(20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_icons[item]!,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).iconTheme.color),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  item.toString().split('.').last,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessButton(SettingsProvider settingsProvider) {
    final buttonType = settingsProvider.quickAccessButtonType;
    final icon = _getQuickAccessIcon(buttonType);
    final screen = _getQuickAccessScreen(buttonType);

    return IconButton(
      icon: Icon(icon),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      onLongPress: () {
        settingsProvider.cycleQuickAccessButton();
      },
    );
  }

  IconData _getQuickAccessIcon(QuickAccessButtonType type) {
    switch (type) {
      case QuickAccessButtonType.notifications:
        return Icons.notifications_none;
      case QuickAccessButtonType.map:
        return Icons.map;
      case QuickAccessButtonType.calendar:
        return Icons.calendar_today;
    }
  }

  Widget _getQuickAccessScreen(QuickAccessButtonType type) {
    switch (type) {
      case QuickAccessButtonType.notifications:
        return const NotificationScreen();
      case QuickAccessButtonType.map:
        return const MapScreen();
      case QuickAccessButtonType.calendar:
        return const CalendarScreen();
    }
  }
}
