import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import '../generated/app_localizations.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  final List<Map<String, dynamic>> _bookings = [
    {
      'id': 1,
      'courtName': 'Court 1',
      'customer': 'John Doe',
      'date': '2024-07-18',
      'time': '09:00 - 10:30',
      'status': 'confirmed',
      'price': '€25.00',
    },
    {
      'id': 2,
      'courtName': 'Court 2',
      'customer': 'Jane Smith',
      'date': '2024-07-18',
      'time': '10:30 - 12:00',
      'status': 'pending',
      'price': '€25.00',
    },
    {
      'id': 3,
      'courtName': 'Court 3',
      'customer': 'Mike Johnson',
      'date': '2024-07-18',
      'time': '14:00 - 15:30',
      'status': 'confirmed',
      'price': '€30.00',
    },
    {
      'id': 4,
      'courtName': 'Court 1',
      'customer': 'Sarah Wilson',
      'date': '2024-07-19',
      'time': '16:00 - 17:30',
      'status': 'cancelled',
      'price': '€25.00',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localizations.bookings,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_list),
                      label: Text(localizations.filter),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.refresh),
                      label: Text(localizations.refresh),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DataTable2(
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    minWidth: 600,
                    columns: [
                      DataColumn2(
                        label: Text(
                          'ID',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        size: ColumnSize.S,
                      ),
                      DataColumn2(
                        label: Text(
                          localizations.courtName,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataColumn2(
                        label: Text(
                          localizations.customer,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataColumn2(
                        label: Text(
                          localizations.date,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataColumn2(
                        label: Text(
                          localizations.time,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataColumn2(
                        label: Text(
                          localizations.status,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataColumn2(
                        label: Text(
                          localizations.price,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataColumn2(
                        label: Text(
                          localizations.actions,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    rows: _bookings.map((booking) {
                      return DataRow2(
                        cells: [
                          DataCell(Text(booking['id'].toString())),
                          DataCell(Text(booking['courtName'])),
                          DataCell(Text(booking['customer'])),
                          DataCell(Text(booking['date'])),
                          DataCell(Text(booking['time'])),
                          DataCell(_buildStatusChip(booking['status'], localizations)),
                          DataCell(Text(booking['price'])),
                          DataCell(
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.visibility, size: 20),
                                  onPressed: () => _showBookingDetails(context, booking, localizations),
                                  tooltip: localizations.view,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit, size: 20),
                                  onPressed: () {},
                                  tooltip: localizations.edit,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                                  onPressed: () => _showDeleteDialog(context, booking, localizations),
                                  tooltip: localizations.delete,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status, AppLocalizations localizations) {
    Color color;
    String text;
    
    switch (status) {
      case 'confirmed':
        color = Colors.green;
        text = localizations.confirmed;
        break;
      case 'pending':
        color = Colors.orange;
        text = localizations.pending;
        break;
      case 'cancelled':
        color = Colors.red;
        text = localizations.cancelled;
        break;
      default:
        color = Colors.grey;
        text = status;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showBookingDetails(BuildContext context, Map<String, dynamic> booking, AppLocalizations localizations) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.bookingDetails),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('ID', booking['id'].toString()),
            _buildDetailRow(localizations.courtName, booking['courtName']),
            _buildDetailRow(localizations.customer, booking['customer']),
            _buildDetailRow(localizations.date, booking['date']),
            _buildDetailRow(localizations.time, booking['time']),
            _buildDetailRow(localizations.status, booking['status']),
            _buildDetailRow(localizations.price, booking['price']),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(localizations.cancel),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Map<String, dynamic> booking, AppLocalizations localizations) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.delete),
        content: Text('Are you sure you want to delete this booking?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(localizations.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _bookings.removeWhere((b) => b['id'] == booking['id']);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Booking deleted successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text(localizations.delete),
          ),
        ],
      ),
    );
  }
}
