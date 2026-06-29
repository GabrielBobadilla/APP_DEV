import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../constants/app_theme.dart';
import '../models/event_model.dart';
import '../services/data_service.dart';

class AllEventsScreen extends StatefulWidget {
  const AllEventsScreen({super.key});

  @override
  State<AllEventsScreen> createState() => _AllEventsScreenState();
}

class _AllEventsScreenState extends State<AllEventsScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final data = context.watch<DataService>();
    final allEvents = data.events;

    final eventDateMap = <DateTime, List<CalendarEvent>>{};
    for (final event in allEvents) {
      final day = DateTime(event.date.year, event.date.month, event.date.day);
      eventDateMap.putIfAbsent(day, () => []);
      eventDateMap[day]!.add(event);
    }

    final selectedEvents = _selectedDay != null
        ? eventDateMap[DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day)] ?? []
        : <CalendarEvent>[];

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: AppShadows.card,
          ),
          child: TableCalendar(
            firstDay: DateTime(2025),
            lastDay: DateTime(2027),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onPageChanged: (focusedDay) => _focusedDay = focusedDay,
            eventLoader: (day) => eventDateMap.keys.where((d) =>
              d.year == day.year && d.month == day.month && d.day == day.day
            ).toList(),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              todayTextStyle: const TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold,
              ),
              selectedDecoration: const BoxDecoration(
                color: AppColors.primary, shape: BoxShape.circle,
              ),
              markerDecoration: const BoxDecoration(
                color: AppColors.primaryLight, shape: BoxShape.circle,
              ),
              markerSize: 6,
              weekendTextStyle: const TextStyle(color: AppColors.textSecondary),
              defaultTextStyle: const TextStyle(color: AppColors.textPrimary),
              outsideTextStyle: TextStyle(color: Colors.grey[300]),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary,
              ),
              leftChevronIcon: const Icon(Icons.chevron_left_rounded, color: AppColors.primary),
              rightChevronIcon: const Icon(Icons.chevron_right_rounded, color: AppColors.primary),
              headerPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, eventsList) {
                if (eventsList.isNotEmpty) {
                  return Positioned(
                    bottom: 2,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryLight,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.event_rounded, size: 16, color: AppColors.primary),
              ),
              const SizedBox(width: 8),
              const Text(
                'All RPAG Events',
                style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              if (_selectedDay != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${selectedEvents.length} event${selectedEvents.length != 1 ? 's' : ''}',
                    style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.primary,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: selectedEvents.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.event_busy_rounded, size: 44, color: Colors.grey[300]),
                      const SizedBox(height: 10),
                      Text(
                        _selectedDay == null
                            ? 'Tap a date to view all RPAG events'
                            : 'No events on this date',
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async => setState(() {}),
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
                    itemCount: selectedEvents.length,
                    itemBuilder: (context, index) {
                      final event = selectedEvents[index];
                      final rpag = data.getRpagById(event.rpagId);
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: AppDecorations.card,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 4,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [AppColors.primary, AppColors.primaryLight],
                                      ),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          event.title,
                                          style: const TextStyle(
                                            fontSize: 15, fontWeight: FontWeight.w600,
                                            color: AppColors.textPrimary, height: 1.2,
                                          ),
                                        ),
                                        if (rpag != null) ...[
                                          const SizedBox(height: 4),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: AppColors.primary.withValues(alpha: 0.08),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              rpag.name,
                                              style: const TextStyle(
                                                fontSize: 11, fontWeight: FontWeight.w500,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (event.description.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          event.description,
                                          style: const TextStyle(
                                            fontSize: 13, color: AppColors.textSecondary, height: 1.3,
                                          ),
                                        ),
                                      ),
                                    Row(
                                      children: [
                                        const Icon(Icons.schedule_rounded, size: 14, color: AppColors.textSecondary),
                                        const SizedBox(width: 4),
                                        Text(event.time, style: AppTextStyles.caption),
                                        const SizedBox(width: 14),
                                        const Icon(Icons.location_on_rounded, size: 14, color: AppColors.textSecondary),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(event.location, style: AppTextStyles.caption, overflow: TextOverflow.ellipsis),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }
}
