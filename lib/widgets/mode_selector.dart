
// lib/widgets/mode_selector.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pazhagu/providers/mode_provider.dart';
import 'package:pazhagu/widgets/styled_container.dart';

class ModeSelector extends StatefulWidget {
  const ModeSelector({Key? key}) : super(key: key);

  @override
  State<ModeSelector> createState() => _ModeSelectorState();
}

class _ModeSelectorState extends State<ModeSelector> {
  bool _isCollapsed = false;

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
                  icon: Icon(_isCollapsed ? Icons.chevron_right : Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      _isCollapsed = !_isCollapsed;
                    });
                  },
                ),
                if (!_isCollapsed)
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...modeProvider.allModes.map((mode) => _buildModeButton(
                            context,
                            mode,
                            modeProvider,
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
