import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:arraid/config/colors.dart'; // assuming you're using your custom ColorManager

class ViewsTable extends StatelessWidget {
  const ViewsTable({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<ViewsTableData> data; // List of ViewsTableData

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Table Header with Labels
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 10),
            child: Row(
              children: const [
                Expanded(
                  child: Text(
                    '  Email',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.greyText,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Date',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.greyText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Actions',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.greyText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.grey), // Horizontal line separating header from content

          // Table rows for the data (ListView wrapped inside a Column)
          ListView.builder(
            shrinkWrap: true, // Allows ListView to take only as much space as needed
            physics: NeverScrollableScrollPhysics(), // Disable internal scroll (scrolling handled by outer view)
            itemCount: data.length,
            itemBuilder: (context, index) {
              final view = data[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0), // Adding space between rows
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(3), // Fixed width for view name column
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(2), // Flexible width for actions column
                  },
                  children: [
                    TableRow(
                      children: [
                        // Column 1: View Name
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.visibility, color: Color(0xFFF1C40F)),
                                onPressed: () {
                                  _showViewInfoDialog(view);
                                },
                              ),
                              
                              Expanded(
                                flex: 3,
                                child: Text(
                                  view.email,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.TextColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Column 2: Description
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 23.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  view.date,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.TextColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Column 3: Actions (Edit, Delete)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: view.onEdit,
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: view.onDelete,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Show View Info Dialog
  void _showViewInfoDialog(ViewsTableData view) {
    Get.dialog(
      AlertDialog(
        title: Text('View Information'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             _buildCopyableText('Name: ${view.name}', view.name),
            _buildCopyableText('Email: ${view.email}', view.email),
            _buildCopyableText('Phone: ${view.phone}', view.phone),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();  // Close the dialog
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildCopyableText(String label, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: SelectableText(
              '$label ',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.copy, color: Colors.blue),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: content));
              Get.snackbar('Copied', 'Copied to clipboard!',
                  snackPosition: SnackPosition.BOTTOM);
            },
          ),
        ],
      ),
    );
  }
}
class ViewsTableData {
 final String name;
  final String email;
  final String phone;
  final String date;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  ViewsTableData({
    required this.name,
    required this.email,
    required this.phone,
    
    required this.date,
    required this.onEdit,
    required this.onDelete,
  });
}