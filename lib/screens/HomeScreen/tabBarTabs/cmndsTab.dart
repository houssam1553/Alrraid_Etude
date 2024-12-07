import 'package:arraid/commun%20widgets/formInput.dart';
import 'package:arraid/config/colors.dart';
import 'package:arraid/config/enums.dart';
import 'package:arraid/repositories/devisRepo.dart';
import 'package:arraid/screens/HomeScreen/widgets/commandsTable.dart';
import 'package:arraid/screens/HomeScreen/widgets/projectsTable.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';



class CommandsTabController extends GetxController {
  final DevisRepository devisRepository;

  // Constructor to inject DevisRepository
  CommandsTabController(this.devisRepository);

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
    fetchCommands();
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
  Future<void> fetchCommands() async {
    try {
      // Fetch and categorize the commands
      var categorizedCommands = await devisRepository.fetchAndCategorizeCommands();
     

      // Update the observables with the categorized data
      if (categorizedCommands.containsKey('devis')) {
        devis.value = categorizedCommands['devis']!;
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


class CommandsTab extends StatefulWidget {
  @override
  _CommandsTabState createState() => _CommandsTabState();
}

class _CommandsTabState extends State<CommandsTab> {


  
  final CommandsTabController controller = Get.find<CommandsTabController>();

  @override
  void initState() {
    // TODO: implement initState
 controller.fetchCommands();


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
              if (controller.commands.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(height: 50,),

                      Text(
                        'No commands available.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(top: 14.0, left: 14, right: 14),
              child: CommandsActionTable(
  data: controller.commands.map((command) {
    return CommandsTableData(
      phone: command['phone'] ?? 'Untitled Command',
      email: command['email'] ?? 'Untitled Command',
       date: _formatDate(command['createdAt'] ?? 'Untitled Command'),
  
      name: command['fullname'] ?? 'Untitled Command',
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
           
          ],
        ),
      ),
    );
  }
}
