import 'package:flutter/material.dart';
import '../generated/app_localizations.dart';

class CourtsScreen extends StatefulWidget {
  const CourtsScreen({super.key});

  @override
  State<CourtsScreen> createState() => _CourtsScreenState();
}

class _CourtsScreenState extends State<CourtsScreen> {
  final List<Map<String, dynamic>> _courts = [
    {
      'id': 1,
      'name': 'Court 1',
      'location': 'Building A',
      'status': 'active',
      'capacity': 4,
      'price': '€25.00/hour',
      'amenities': ['Lighting', 'Air Conditioning', 'Equipment Rental'],
    },
    {
      'id': 2,
      'name': 'Court 2',
      'location': 'Building A',
      'status': 'active',
      'capacity': 4,
      'price': '€25.00/hour',
      'amenities': ['Lighting', 'Equipment Rental'],
    },
    {
      'id': 3,
      'name': 'Court 3',
      'location': 'Building B',
      'status': 'inactive',
      'capacity': 4,
      'price': '€30.00/hour',
      'amenities': ['Lighting', 'Air Conditioning', 'Sound System'],
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
                  localizations.courts,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _showAddCourtDialog(context, localizations),
                  icon: const Icon(Icons.add),
                  label: Text(localizations.addCourt),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _courts.length,
                itemBuilder: (context, index) {
                  final court = _courts[index];
                  return _buildCourtCard(context, court, localizations);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourtCard(BuildContext context, Map<String, dynamic> court, AppLocalizations localizations) {
    final isActive = court['status'] == 'active';
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  court['name'],
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          const Icon(Icons.visibility, size: 20),
                          const SizedBox(width: 8),
                          Text(localizations.view),
                        ],
                      ),
                      onTap: () => _showCourtDetails(context, court, localizations),
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          const Icon(Icons.edit, size: 20),
                          const SizedBox(width: 8),
                          Text(localizations.edit),
                        ],
                      ),
                      onTap: () {},
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          const Icon(Icons.delete, size: 20, color: Colors.red),
                          const SizedBox(width: 8),
                          Text(localizations.delete),
                        ],
                      ),
                      onTap: () => _showDeleteCourtDialog(context, court, localizations),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  court['location'],
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isActive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isActive ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3),
                ),
              ),
              child: Text(
                isActive ? localizations.active : localizations.inactive,
                style: TextStyle(
                  color: isActive ? Colors.green : Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Icon(
                  Icons.people,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  '${localizations.capacity}: ${court['capacity']}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              court['price'],
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2196F3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCourtDetails(BuildContext context, Map<String, dynamic> court, AppLocalizations localizations) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.courtDetails),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow(localizations.name, court['name']),
              _buildDetailRow(localizations.location, court['location']),
              _buildDetailRow(localizations.status, court['status']),
              _buildDetailRow(localizations.capacity, court['capacity'].toString()),
              _buildDetailRow(localizations.price, court['price']),
              const SizedBox(height: 8),
              Text(
                localizations.amenities,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              ...court['amenities'].map<Widget>((amenity) => Padding(
                padding: const EdgeInsets.only(left: 16, top: 2),
                child: Row(
                  children: [
                    const Icon(Icons.check, size: 16, color: Colors.green),
                    const SizedBox(width: 4),
                    Text(amenity),
                  ],
                ),
              )),
            ],
          ),
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

  void _showAddCourtDialog(BuildContext context, AppLocalizations localizations) {
    final nameController = TextEditingController();
    final locationController = TextEditingController();
    final capacityController = TextEditingController();
    final priceController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.addCourt),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: localizations.name,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: localizations.location,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: capacityController,
                decoration: InputDecoration(
                  labelText: localizations.capacity,
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: localizations.price,
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(localizations.cancel),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                setState(() {
                  _courts.add({
                    'id': _courts.length + 1,
                    'name': nameController.text,
                    'location': locationController.text,
                    'status': 'active',
                    'capacity': int.tryParse(capacityController.text) ?? 4,
                    'price': priceController.text,
                    'amenities': ['Lighting'],
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${localizations.success}!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: Text(localizations.save),
          ),
        ],
      ),
    );
  }

  void _showDeleteCourtDialog(BuildContext context, Map<String, dynamic> court, AppLocalizations localizations) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.delete),
        content: Text('Are you sure you want to delete ${court['name']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(localizations.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _courts.removeWhere((c) => c['id'] == court['id']);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Court deleted successfully'),
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
