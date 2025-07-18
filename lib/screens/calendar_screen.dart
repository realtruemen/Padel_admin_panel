import 'package:flutter/material.dart';
import '../generated/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../providers/currency_provider.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late final ValueNotifier<List<Map<String, dynamic>>> _selectedBookings;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late Map<DateTime, List<Map<String, dynamic>>> _bookings;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedBookings = ValueNotifier([]);
  }

  @override
  void dispose() {
    _selectedBookings.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    _bookings = _getBookingsData(currencyProvider);
    _selectedBookings.value = _getBookingsForDay(_selectedDay!);
  }

  Map<DateTime, List<Map<String, dynamic>>> _getBookingsData(CurrencyProvider currencyProvider) {
    return {
      // Past dates
      DateTime(2025, 1, 15): [
        {
          'id': 19,
          'courtName': 'Court 1',
          'customer': 'Past User 1',
          'time': '10:00 - 11:30',
          'status': 'confirmed',
          'price': currencyProvider.formatPrice(25.00),
        },
      ],
      // Today - July 18, 2025
      DateTime(2025, 7, 18): [
        {
          'id': 1,
          'courtName': 'Court 1',
          'customer': 'John Doe',
          'time': '10:00 - 11:30',
          'status': 'confirmed',
          'price': currencyProvider.formatPrice(25.00),
        },
        {
          'id': 2,
          'courtName': 'Court 2',
          'customer': 'Jane Smith',
          'time': '14:00 - 15:30',
          'status': 'pending',
          'price': currencyProvider.formatPrice(30.00),
        },
      ],
      // Tomorrow
      DateTime(2025, 7, 19): [
        {
          'id': 3,
          'courtName': 'Court 1',
          'customer': 'Mike Johnson',
          'time': '09:00 - 10:30',
          'status': 'confirmed',
          'price': currencyProvider.formatPrice(25.00),
        },
      ],
      // Day after tomorrow
      DateTime(2025, 7, 20): [
        {
          'id': 4,
          'courtName': 'Court 3',
          'customer': 'Sarah Wilson',
          'time': '16:00 - 17:30',
          'status': 'confirmed',
          'price': currencyProvider.formatPrice(35.00),
        },
        {
          'id': 5,
          'courtName': 'Court 1',
          'customer': 'Tom Brown',
          'time': '18:00 - 19:30',
          'status': 'cancelled',
          'price': currencyProvider.formatPrice(25.00),
        },
      ],
      DateTime(2025, 7, 25): [
        {
          'id': 6,
          'courtName': 'Court 2',
          'customer': 'Lisa Davis',
          'time': '11:00 - 12:30',
          'status': 'confirmed',
          'price': currencyProvider.formatPrice(30.00),
        },
        {
          'id': 7,
          'courtName': 'Court 3',
          'customer': 'Alex Miller',
          'time': '13:00 - 14:30',
          'status': 'confirmed',
          'price': currencyProvider.formatPrice(35.00),
        },
        {
          'id': 8,
          'courtName': 'Court 1',
          'customer': 'Emma Taylor',
          'time': '15:00 - 16:30',
          'status': 'confirmed',
          'price': currencyProvider.formatPrice(25.00),
        },
      ],
      // All pending bookings
      DateTime(2025, 7, 26): [
        {
          'id': 9,
          'courtName': 'Court 1',
          'customer': 'David Wilson',
          'time': '10:00 - 11:30',
          'status': 'pending',
          'price': currencyProvider.formatPrice(25.00),
        },
        {
          'id': 10,
          'courtName': 'Court 2',
          'customer': 'Maria Garcia',
          'time': '14:00 - 15:30',
          'status': 'pending',
          'price': currencyProvider.formatPrice(30.00),
        },
      ],
    };
  }

  List<Map<String, dynamic>> _getBookingsForDay(DateTime day) {
    return _bookings[DateTime(day.year, day.month, day.day)] ?? [];
  }

  Color _getBookingColor(String status) {
    switch (status) {
      case 'confirmed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getDayBookingColor(List<Map<String, dynamic>> bookings) {
    if (bookings.isEmpty) return Colors.transparent;
    
    // Eğer tek booking varsa o booking'in rengini kullan
    if (bookings.length == 1) {
      return _getBookingColor(bookings.first['status']);
    }
    
    // Birden fazla booking varsa, hepsinin aynı statüde olup olmadığını kontrol et
    final firstStatus = bookings.first['status'];
    final allSameStatus = bookings.every((booking) => booking['status'] == firstStatus);
    
    if (allSameStatus) {
      // Hepsi aynı statüdeyse o rengi kullan
      return _getBookingColor(firstStatus);
    }
    
    // Farklı statüler varsa mavi renk kullan
    return Colors.blue;
  }

  bool _isPastDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final checkDate = DateTime(date.year, date.month, date.day);
    return checkDate.isBefore(today);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.calendar,
          style: TextStyle(
            color: Theme.of(context).appBarTheme.foregroundColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Row(
        children: [
          // Calendar side
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TableCalendar<Map<String, dynamic>>(
                    firstDay: DateTime.utc(2023, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    eventLoader: _getBookingsForDay,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    calendarStyle: CalendarStyle(
                      outsideDaysVisible: false,
                      weekendTextStyle: const TextStyle(color: Colors.red),
                      cellMargin: const EdgeInsets.all(2.0),
                      defaultDecoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      todayDecoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.5),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      markersMaxCount: 1,
                      canMarkersOverflow: false,
                    ),
                    rowHeight: 70.0,
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                        final bookings = _getBookingsForDay(day);
                        final isPast = _isPastDate(day);
                        
                        return Container(
                          margin: const EdgeInsets.all(2.0),
                          height: 70,
                          decoration: BoxDecoration(
                            color: isPast 
                                ? Theme.of(context).disabledColor.withOpacity(0.3)
                                : Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Theme.of(context).dividerColor,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: bookings.isNotEmpty
                                      ? isPast
                                          ? _getDayBookingColor(bookings).withOpacity(0.3)
                                          : _getDayBookingColor(bookings).withOpacity(0.7)
                                      : Colors.transparent,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '${day.day}',
                                    style: TextStyle(
                                      color: bookings.isNotEmpty 
                                          ? Colors.white 
                                          : (isPast 
                                              ? Theme.of(context).disabledColor 
                                              : Theme.of(context).textTheme.bodyLarge?.color),
                                      fontWeight: bookings.isNotEmpty ? FontWeight.bold : FontWeight.normal,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              if (bookings.isNotEmpty)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      bookings.length == 1
                                          ? '${bookings.first['time']?.split(' - ')[0] ?? ''}\n${bookings.first['courtName']}'
                                          : '+${bookings.length} bookings',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: isPast 
                                            ? Theme.of(context).disabledColor 
                                            : Theme.of(context).textTheme.bodyMedium?.color,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                      selectedBuilder: (context, day, focusedDay) {
                        final bookings = _getBookingsForDay(day);
                        
                        return Container(
                          margin: const EdgeInsets.all(2.0),
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Colors.blue[700]!,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: bookings.isNotEmpty
                                      ? _getDayBookingColor(bookings).withOpacity(0.8)
                                      : Colors.blue[700],
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '${day.day}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              if (bookings.isNotEmpty)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      bookings.length == 1
                                          ? '${bookings.first['time']?.split(' - ')[0] ?? ''}\n${bookings.first['courtName']}'
                                          : '+${bookings.length} bookings',
                                      style: const TextStyle(
                                        fontSize: 8,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                      todayBuilder: (context, day, focusedDay) {
                        final bookings = _getBookingsForDay(day);
                        
                        return Container(
                          margin: const EdgeInsets.all(2.0),
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: bookings.isNotEmpty
                                      ? _getDayBookingColor(bookings).withOpacity(0.8)
                                      : Colors.blue,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '${day.day}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              if (bookings.isNotEmpty)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      bookings.length == 1
                                          ? '${bookings.first['time']?.split(' - ')[0] ?? ''}\n${bookings.first['courtName']}'
                                          : '+${bookings.length} bookings',
                                      style: const TextStyle(
                                        fontSize: 8,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                          _selectedBookings.value = _getBookingsForDay(selectedDay);
                        });
                      }
                    },
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                  ),
                ),
                
                // Legend
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  color: Theme.of(context).colorScheme.background,
                  child: _buildCalendarLegend(context, localizations),
                ),
              ],
            ),
          ),
          
          // Vertical divider
          const VerticalDivider(
            width: 1,
            thickness: 1,
            color: Colors.grey,
          ),
          
          // Bookings side
          Expanded(
            flex: 1,
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: _buildBookingsSection(context, localizations),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildCalendarLegend(BuildContext context, AppLocalizations localizations) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 8.0,
      children: [
        _buildLegendItem(color: Colors.green, label: localizations.confirmed),
        _buildLegendItem(color: Colors.orange, label: localizations.pending),
        _buildLegendItem(color: Colors.red, label: localizations.cancelled),
        _buildLegendItem(
          color: Colors.grey[200]!, 
          label: 'Past Dates', 
          textColor: Theme.of(context).disabledColor,
        ),
      ],
    );
  }

  Widget _buildBookingsSection(BuildContext context, AppLocalizations localizations) {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(
      valueListenable: _selectedBookings,
      builder: (context, bookings, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Bookings for ${_selectedDay?.day}/${_selectedDay?.month}/${_selectedDay?.year}',
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.headlineSmall?.color,
                ),
              ),
            ),
            Expanded(
              child: bookings.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.event_busy, size: 64, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(
                            'No bookings this day',
                            style: TextStyle(
                              fontSize: 16, 
                              color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: bookings.length,
                      itemBuilder: (context, index) {
                        final booking = bookings[index];
                        final statusColor = _getBookingColor(booking['status']);
                        final isPast = _selectedDay != null && _isPastDate(_selectedDay!);
                        
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8.0),
                          elevation: 2,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            leading: Container(
                              width: 4,
                              height: 60,
                              decoration: BoxDecoration(
                                color: statusColor,
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                            ),
                            title: Text(
                              booking['courtName'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isPast 
                                    ? Theme.of(context).disabledColor 
                                    : Theme.of(context).textTheme.titleMedium?.color,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  'Customer: ${booking['customer']}',
                                  style: TextStyle(
                                    color: isPast 
                                        ? Theme.of(context).disabledColor 
                                        : Theme.of(context).textTheme.bodyMedium?.color,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time, 
                                      size: 16, 
                                      color: Theme.of(context).iconTheme.color?.withOpacity(0.6),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      booking['time'],
                                      style: TextStyle(
                                        color: isPast 
                                            ? Theme.of(context).disabledColor 
                                            : Theme.of(context).textTheme.bodyMedium?.color,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      booking['price'],
                                      style: TextStyle(
                                        color: isPast 
                                            ? Theme.of(context).disabledColor 
                                            : Colors.green[700],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(color: statusColor.withOpacity(0.3)),
                              ),
                              child: Text(
                                booking['status'].toUpperCase(),
                                style: TextStyle(
                                  color: statusColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String label,
    Color? textColor,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: textColor ?? Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
      ],
    );
  }
}
