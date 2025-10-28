
// lib/screens/calendar_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pazhagu/providers/mode_provider.dart';
import 'package:pazhagu/services/local_storage_service.dart';
import 'package:pazhagu/widgets/styled_container.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _selectedDate;
  late DateTime _displayedMonth;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _displayedMonth = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ModeProvider, LocalStorageService>(
      builder: (context, modeProvider, localStorageService, _) {
        return Column(
          children: [
            // Month/Year Navigation
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      setState(() {
                        _displayedMonth = DateTime(
                          _displayedMonth.year,
                          _displayedMonth.month - 1,
                        );
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () => _showMonthYearPicker(),
                    child: Text(
                      '${_getMonthName(_displayedMonth.month)} ${_displayedMonth.year}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      setState(() {
                        _displayedMonth = DateTime(
                          _displayedMonth.year,
                          _displayedMonth.month + 1,
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
            // Calendar Grid
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: StyledContainer(
                        child: Column(
                          children: [
                            _buildDayHeaders(),
                            _buildCalendarGrid(modeProvider.currentMode.name.toLowerCase()),
                          ],
                        ),
                      ),
                    ),
                    // Daily Events
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: FutureBuilder<List<Map<String, dynamic>>>(
                        future: localStorageService.getEvents(
                          modeProvider.currentMode.name.toLowerCase(),
                          _dateToString(_selectedDate),
                        ),
                        builder: (context, snapshot) {
                          if (localStorageService.database == null) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          final events = snapshot.data ?? [];

                          if (events.isEmpty) {
                            return StyledContainer(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today,
                                      size: 48,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(height: 8),
                                    const Text('No events on this day'),
                                  ],
                                ),
                              ),
                            );
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Events Today',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ...events.map(
                                    (event) => _buildEventTile(event),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDayHeaders() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (final day in ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'])
            Expanded(
              child: Center(
                child: Text(
                  day,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid(String mode) {
    final firstDay = DateTime(_displayedMonth.year, _displayedMonth.month, 1);
    final lastDay = DateTime(_displayedMonth.year, _displayedMonth.month + 1, 0);
    final prevLastDay = DateTime(_displayedMonth.year, _displayedMonth.month, 0);

    final daysInMonth = lastDay.day;
    final startingDayOfWeek = firstDay.weekday % 7;

    final days = <DateTime>[];

    // Previous month days
    for (int i = startingDayOfWeek - 1; i >= 0; i--) {
      days.add(prevLastDay.subtract(Duration(days: i)));
    }

    // Current month days
    for (int i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(_displayedMonth.year, _displayedMonth.month, i));
    }

    // Next month days
    final remainingDays = 42 - days.length;
    for (int i = 1; i <= remainingDays; i++) {
      days.add(DateTime(_displayedMonth.year, _displayedMonth.month + 1, i));
    }

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: GridView.count(
        crossAxisCount: 7,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: days
            .map((day) => GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = day;
            });
          },
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: _isSameDay(day, _selectedDate)
                  ? const Color(0xFF4A90E2)
                  : Colors.transparent,
              border: _isSameDay(day, DateTime.now())
                  ? Border.all(color: Colors.blue)
                  : null,
            ),
            child: Center(
              child: Text(
                day.day.toString(),
                style: TextStyle(
                  color: _isSameDay(day, _selectedDate)
                      ? Colors.white
                      : isDarkMode ? Colors.white : Colors.black87,
                  fontWeight: _isSameDay(day, _selectedDate)
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ),
        ))
            .toList(),
      ),
    );
  }

  Widget _buildEventTile(Map<String, dynamic> event) {
    return StyledContainer(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.event),
        title: Text(event['title'] ?? 'Event'),
        subtitle: Text(event['description'] ?? ''),
        trailing: event['reminder'] == 1
            ? const Icon(Icons.notifications_active)
            : null,
        onTap: () {
          // Edit event
        },
      ),
    );
  }

  bool _isSameDay(DateTime day1, DateTime day2) {
    return day1.year == day2.year &&
        day1.month == day2.month &&
        day1.day == day2.day;
  }

  String _dateToString(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  void _showMonthYearPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Month & Year'),
        content: SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Month selector
              DropdownButton<int>(
                value: _displayedMonth.month,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _displayedMonth = DateTime(_displayedMonth.year, value);
                    });
                    Navigator.pop(context);
                  }
                },
                items: List.generate(
                  12,
                      (index) => DropdownMenuItem(
                    value: index + 1,
                    child: Text(_getMonthName(index + 1)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Year selector
              DropdownButton<int>(
                value: _displayedMonth.year,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _displayedMonth = DateTime(value, _displayedMonth.month);
                    });
                    Navigator.pop(context);
                  }
                },
                items: List.generate(
                  10,
                      (index) => DropdownMenuItem(
                    value: DateTime.now().year - 5 + index,
                    child: Text((DateTime.now().year - 5 + index).toString()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
