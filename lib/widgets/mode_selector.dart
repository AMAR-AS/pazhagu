
// lib/widgets/mode_selector.dart

import 'package:flutter/material.dart';
import 'package:pazhagu/providers/settings_provider.dart';
import 'package:pazhagu/services/search_service.dart';
import 'package:provider/provider.dart';
import 'package:pazhagu/providers/mode_provider.dart';
import 'package:pazhagu/widgets/styled_container.dart';

class ModeSelector extends StatefulWidget {
  final bool isCollapsed;
  final ValueChanged<bool> onCollapseChanged;

  const ModeSelector({
    Key? key,
    required this.isCollapsed,
    required this.onCollapseChanged,
  }) : super(key: key);

  @override
  State<ModeSelector> createState() => _ModeSelectorState();
}

class _ModeSelectorState extends State<ModeSelector> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModeProvider>(
      builder: (context, modeProvider, _) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: StyledContainer(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(widget.isCollapsed ? Icons.chevron_right : Icons.chevron_left),
                  onPressed: () => widget.onCollapseChanged(!widget.isCollapsed),
                ),
                if (widget.isCollapsed)
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                        isDense: true,
                        prefixIcon: FadeTransition(
                          opacity: _animationController,
                          child: const Icon(Icons.search),
                        ),
                      ),
                      onSubmitted: (value) {
                        final settingsProvider = context.read<SettingsProvider>();
                        final searchService = context.read<SearchService>();
                        final visibleItems = settingsProvider.navItemOrder
                            .where((item) => settingsProvider.navItemVisibility[item]!)
                            .toList();
                        final currentItem = visibleItems[settingsProvider.navItemOrder.indexOf(NavItem.home)];

                        searchService.search(value, currentItem);
                      },
                    ),
                  )
                else
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...modeProvider.allModes.map((mode) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: _buildModeButton(
                                  context,
                                  mode,
                                  modeProvider,
                                ),
                          )),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => _showAddModeDialog(context),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildModeButton(
    BuildContext context,
    AppMode mode,
    ModeProvider modeProvider,
  ) {
    final isActive = modeProvider.currentMode == mode;
    final isCustom = mode.icon == null;

    return GestureDetector(
      onTap: () => modeProvider.switchMode(mode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: isActive
              ? const LinearGradient(
                  colors: [Color(0xFF4A90E2), Color(0xFF00D4FF)],
                )
              : null,
          color: isActive ? null : Colors.transparent,
          border: Border.all(
            color: isActive ? Colors.transparent : Colors.white24,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isCustom)
              Text(mode.emoji!, style: const TextStyle(fontSize: 18))
            else
              Icon(mode.icon, size: 18, color: isActive ? Colors.white : null),
            if (isActive && (!isCustom || (isCustom && isActive))) ...[
              const SizedBox(width: 4),
              Text(
                mode.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showAddModeDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emojiController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Chat Grouping'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Grouping Name'),
              ),
              TextField(
                controller: emojiController,
                decoration: const InputDecoration(hintText: 'Emoji'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty && emojiController.text.isNotEmpty) {
                  Provider.of<ModeProvider>(context, listen: false).addMode(
                    name: nameController.text,
                    emoji: emojiController.text,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
