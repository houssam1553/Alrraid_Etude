import 'package:arraid/config/colors.dart';
import 'package:flutter/material.dart';

class ProjectsActionTable extends StatelessWidget {
  const ProjectsActionTable({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<ProjectActionData> data; // List of project action data

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
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: const [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Projets',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.greyText,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Actions',
                    style: TextStyle(
                      fontSize: 16,
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
              final user = data[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0), // Adding space between rows
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(), // Fixed width for image column
                    1: FlexColumnWidth(), // Flexible width for actions column
                  },
                  children: [
                    TableRow(
                      children: [
                        // Column 1: Image and Name
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                             Container(
                                width: 60, // Width of the container (can be adjusted)
                                height:60, // Height of the container (can be adjusted)
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8), // Rounded corners
                                  image: DecorationImage(
                                    image: NetworkImage(user.imagePath,  ),onError: ( error, stackTrace) {
           Container(
           
            alignment: Alignment.center,
           child: Image.asset("assets/images/arraidLogo.png")
          );
        },
                                    fit: BoxFit.cover, // Ensures image covers the container
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Text(
                                  user.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.TextColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Column 2: Actions (Edit, Delete)
                        Padding(
                          padding:  EdgeInsets.symmetric(vertical: 8.0,),
                          child: Container(
                            width: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Color(0xFFF1C40F)),
                                  onPressed: user.onEdit,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: user.onDelete,
                                ),
                              ],
                            ),
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
}

class ProjectActionData {
  final String imagePath;
  final String name;
  final String status;
  final String id;


  final VoidCallback onEdit;
  final VoidCallback onDelete;

  ProjectActionData({
    required this.imagePath,
    required this.name,
    required this.status,
    required this.id,
    

    required this.onEdit,
    required this.onDelete,
  });
}
