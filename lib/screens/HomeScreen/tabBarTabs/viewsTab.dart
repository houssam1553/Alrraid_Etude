import 'package:arraid/commun%20widgets/formInput.dart';
import 'package:arraid/config/colors.dart';
import 'package:arraid/config/enums.dart';
import 'package:arraid/repositories/devisRepo.dart';
import 'package:arraid/screens/HomeScreen/widgets/commandsTable.dart';
import 'package:arraid/screens/HomeScreen/widgets/projectsTable.dart';
import 'package:arraid/screens/HomeScreen/widgets/viewsTable.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';



class ViewsTabController extends GetxController {
  final DevisRepository devisRepository;

  // Constructor to inject DevisRepository
  ViewsTabController(this.devisRepository);

  // Observable for views
  var views = <Map<String, dynamic>>[].obs; 

  // Fetch views when the controller is initialized
  @override
  void onInit() {
    super.onInit();
    fetchViews();
  }

  // Fetch views data from the repository
  Future<void> fetchViews() async {
    try {
      // Fetch the views
      var viewsData = await devisRepository.fetchViews();

      // Update the observable with the fetched data
      views.value = viewsData;
    } catch (e) {
      print('Error fetching views: $e');
      // Handle the error, such as showing a Snackbar or another UI indicator
    }
  }
}
class ViewsTab extends StatefulWidget {
  @override
  _ViewsTabState createState() => _ViewsTabState();
}

class _ViewsTabState extends State<ViewsTab> {
  final ViewsTabController controller = Get.find<ViewsTabController>();

  @override
  Widget build(BuildContext context) {
    String _formatDate(String dateStr) {
      try {
        return DateFormat('yyyy-MM-dd').format(DateTime.parse(dateStr));
      } catch (e) {
        return 'Untitled View';  // Default in case of invalid date format
      }
    }

    return Container(
      color: ColorManager.lightPrimary,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              if (controller.views.isEmpty) {
                return Center(
                  child: Text(
                    'No views available.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(top: 14.0, left: 14, right: 14),
                child: ViewsTable(
                  data: controller.views.map((view) {
                    return ViewsTableData(
                      email: view['email'] ?? 'Untitled View',
                      name: view['fullname'] ?? 'Untitled View',
                      phone: view['phone'] ?? 'Untitled View',
                      date: _formatDate(view['createdAt'] ?? 'Untitled View'),
                      onEdit: () {
                        // Add edit functionality if needed
                      },
                      onDelete: () => print('Delete ${view['fullname']}'),
                    );
                  }).toList(),
                ),
              );
            }),
            const SizedBox(height: 20),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.0557,
            //   width: MediaQuery.of(context).size.width * 0.63,
            //   child: ElevatedButton(
            //     style: ButtonStyle(
            //       backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF27AE60)),
            //     ),
            //     onPressed: () {
            //       // Add the function to toggle to the form view or any other functionality
            //     },
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(
            //           "Ajouter View",  // Update text to reflect "View"
            //           style: Theme.of(context).textTheme.labelLarge?.copyWith(
            //                 color: Theme.of(context).brightness == Brightness.dark
            //                     ? Colors.black
            //                     : Colors.white,
            //               ),
            //         ),
            //         const SizedBox(width: 10),
            //         const Icon(Icons.add),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
