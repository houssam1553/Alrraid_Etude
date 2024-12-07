import 'package:arraid/commun%20widgets/formInput.dart';
import 'package:arraid/config/colors.dart';
import 'package:arraid/config/enums.dart';
import 'package:arraid/repositories/devisRepo.dart';
import 'package:arraid/screens/HomeScreen/widgets/commandsTable.dart';
import 'package:arraid/screens/HomeScreen/widgets/devisTable.dart';
import 'package:arraid/screens/HomeScreen/widgets/projectsTable.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';



class DevisTabController extends GetxController {
  final DevisRepository devisRepository;

  // Constructor to inject DevisRepository
  DevisTabController(this.devisRepository);

  var projectName = ''.obs;
  var localisation = ''.obs;
  var uploadedFileName = ''.obs;

  late DropzoneViewController dropzoneController;
  
  // Observable for commands and devis
  var commands = <Map<String, dynamic>>[].obs;
  var devis = <Map<String, dynamic>>[].obs; 

  // Fetch commands when the controller is initialized
  @override
  void onInit() {
    super.onInit();
    fetchDevis();
    devisRepository.loadAndPrintCommands();
  }

  // Method to pick a file
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String fileName = result.files.single.name;
      uploadedFileName.value = fileName;
      print('File picked: $fileName');
    }
  }

  // Fetch and categorize commands from the repository
  Future<void> fetchDevis() async {
    try {
      // Fetch and categorize the commands
      var categorizedCommands = await devisRepository.fetchAndCategorizeCommands();

      // Update the observables with the categorized data
      if (categorizedCommands.containsKey('devis')) {
        devis.value = categorizedCommands['devis']!;
              print("catt ==== $devis");

      }
      if (categorizedCommands.containsKey('commands')) {
        commands.value = categorizedCommands['commands']!;
      }
    
    } catch (e) {
      print('Error fetching commands: $e');
      // You could show a Snackbar or other UI indicator to inform the user
    }
  }
}


class DevisTab extends StatefulWidget {
  @override
  _DevisTabState createState() => _DevisTabState();
}

class _DevisTabState extends State<DevisTab> {
  final DevisTabController controller = Get.find<DevisTabController>();
@override
  void initState() {
    // TODO: implement initState
   controller.fetchDevis();
   
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String _formatDate(String dateStr) {
  try {
    return DateFormat('yyyy-MM-dd').format(DateTime.parse(dateStr));
  } catch (e) {
    return 'Untitled Command';  // In case of any error (e.g., invalid date format)
  }
}

    return Container(
      color: ColorManager.lightPrimary,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              if (controller.devis.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(height: 50,),
                      Text(
                        'No Devis available.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(top: 14.0, left: 14, right: 14),
              child: Devistable(
  data: controller.devis.map((command) {
    return DevisTableData(
  
       date: _formatDate(command['createdAt'] ?? 'Untitled Command'),
  
    
      onEdit: () {
        // Add the editing functionality here
      },
      onDelete: () => print('Delete ${command['title']}'),
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
            //       // Add the function to toggle to the form view
            //     },
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(
            //           "Ajouter Commandes",
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
