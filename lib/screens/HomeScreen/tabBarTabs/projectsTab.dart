import 'package:arraid/commun%20widgets/formInput.dart';
import 'package:arraid/config/colors.dart';
import 'package:arraid/config/enums.dart';
import 'package:arraid/repositories/devisRepo.dart';
import 'package:arraid/screens/HomeScreen/widgets/projectsTable.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

enum ProjectView { list, add, details, edit }

class ProjetsTabController extends GetxController {
  final DevisRepository devisRepository;
  ProjetsTabController(this.devisRepository);
  var currentView = ProjectView.list.obs; // Observes the current view.
  var projectName = ''.obs;
  var localisation = ''.obs;
  var projectId = ''.obs;
  var toggleState = false.obs;

  

  // Observes the uploaded file name.
  var uploadedFileName = ''.obs;

  var isLoading = false.obs;
  var isSLoading = false.obs;


  late DropzoneViewController dropzoneController;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String fileName = result.files.single.name;
      uploadedFileName.value = fileName;
      print('File picked: $fileName');
    }
  }

  var status = ''.obs;

  Future<void> changePojectInfo(
      String _projectName, String _localisation, String _id) async {

    projectName.value = _projectName;
    localisation.value = _localisation;
    projectId.value = _id;
    print('=========${projectId.value}');
    

  }

  void changeView(ProjectView view, {Map<String, dynamic>? project}) {
    currentView.value = view;

    if (project != null) {
      print(project);
      projectName.value = project['title'] ?? '';
      localisation.value = project['address'] ?? '';
      status.value = project['status'] ?? '';
    //  projectId.value = project['id'] ?? '';

    }
  }

  var projects = <Map<String, dynamic>>[].obs;

  // Constructor to inject DevisRepository

  @override
  void onInit() {
    super.onInit();
    // Fetch projects when the controller is initialized
    fetchProjects();
  }

  // Method to fetch projects from the repository
  Future<void> fetchProjects() async {
    isLoading.value = true;
    try {
      // Fetch the list of projects from the repository
      var fetchedProjects = await devisRepository.fetchProjects();
      isLoading.value = false;
      // Update the 'projects' observable with the fetched data
      projects.value = fetchedProjects.map((project) {
        return {
          'thumbnail': 'https://etude.alrraid.com' +
              project['thumbnail'],
          'title': project['title'],
          'description': project['description'],
          'url': project['url'],
          'status': project['status'],
          'id': project['_id'],

          
          
          
          // Add any other fields you need here
        };
      }).toList();
    } catch (e) {
      isLoading.value = false;
      // Handle any errors that occur during the API call
      print('Error fetching projects: $e');
      // You could show a Snackbar or other UI indicator to inform the user
    }
  }
   Future<void> toggleProjectActivation(String projectId, bool isActive) async {
     isSLoading.value = true;
    try {
     
      await devisRepository.activateProject(projectId, isActive);
      await devisRepository.subscribeProject(projectId,isActive);


      isSLoading.value = false;

      // Update the local status if needed
      var projectIndex =
          projects.indexWhere((project) => project['id'] == projectId);
      if (projectIndex != -1) {
        projects[projectIndex]['status'] = isActive ? 'active' : 'inactive';
        projects.refresh();
      }
 Get.back();
      
      // Notify success
     Get.snackbar(
      duration: Duration(seconds: 3),
  'Succès',
  'le parmatres du projet mise à jour ! ',
  snackPosition: SnackPosition.BOTTOM,
);
    } catch (e) {
      isSLoading.value = false;
      print('Error toggling project activation: $e');
    }
  }
}

class ProjectsTab extends StatefulWidget {
  @override
  _ProjectsTabState createState() => _ProjectsTabState();
}

class _ProjectsTabState extends State<ProjectsTab> {
  final ProjetsTabController controller = Get.find<ProjetsTabController>();

  @override
  void initState() {
    // TODO: implement initState
    controller.fetchProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.lightPrimary,
      child: Obx(() {
        print(controller.currentView.value);
        return Builder(
          builder: (context) {
            switch (controller.currentView.value) {
              case ProjectView.list:
                return _buildProjectList(context);
              case ProjectView.add:
                return _buildAddProjectForm(context);
              case ProjectView.details:
                return _buildProjectDetails(context);
              case ProjectView.edit:
                return _buildEditProjectForm(context);
              default:
                return _buildProjectList(context);
            }
          },
        );
      }),
    );
  }

  // Existing methods
  Widget _buildProjectList(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
       
               Obx((){
                 return CustomMaterialIndicator(
                      onRefresh: () async {
                               // Call the refresh logic to load team members
                               await Future.delayed(Duration(seconds: 2)); // Show success animation
                               
                               await controller.fetchProjects();
                      },
                      backgroundColor: Colors.white,
                      indicatorBuilder: (context, controller) {
                               return controller.value < 0.5
                    ? Icon(
                        Icons.refresh, // Circular refresh arrow icon
                        color: ColorManager.primary, // Replace with your desired color
                        size: 30, // Adjust size if needed
                      )
                    : Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: CircularProgressIndicator(
                          color: ColorManager.primary,
                          backgroundColor: ColorManager.greyText,
                        ),
                      );
                      },
                      child: Column(
                               children: [
                
                    if (controller.projects.isEmpty) 
                       Center(
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: CircularProgressIndicator(
                            color: ColorManager.primary,
                            backgroundColor: ColorManager.greyText,
                          ),
                        ),
                      )
                     else
                     Padding(
                      padding: const EdgeInsets.only(top: 14.0, left: 14, right: 14),
                      child: ProjectsActionTable(
                        data: controller.projects.map((project) {
                          return ProjectActionData(
                            imagePath:
                                project['thumbnail'] ?? 'assets/images/placeholder.png',
                            name: project['title'] ?? 'Untitled Project',
                            status: project['status']?? 'disactive',
                                               id: project['id']?? 'default id',
                               
                            
                            onEdit: () {
                              controller.changePojectInfo(
                                  project['title'] ?? '', project['description'] ?? '', project['id'] ?? '',);
                               
                              controller.changeView(ProjectView.edit, project: {
                                'title': project['title'],
                                'address':
                                    project['description'], // or localisation field
                                'status': project['status'],
                                'id': project['_id'],
                               
                                
                              });
                              print('**********$project');
                            },
                            onDelete: () => print('Delete ${project['title']}'),
                          );
                        }).toList(),
                      ),
                    ),
                  const SizedBox(height: 20),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.0557,
                  //   width: MediaQuery.of(context).size.width * 0.63,
                  //   child: ElevatedButton(
                  //     style: ButtonStyle(
                  //       backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF27AE60)),
                  //     ),
                  //     onPressed: () => controller.changeView(ProjectView.add), // Toggles to the form view.
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Text(
                  //           "Ajouter projets",
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
                    
                             );}
               ),
          ],
        ));
  }

  Widget _buildAddProjectForm(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => controller.changeView(ProjectView.list),
                    icon: Icon(Icons.arrow_back),
                  ),
                  Column(
                    children: [
                      Text(
                        "Ajouter un projet",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontSize: 34),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Rempli les champs suivants",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                fontSize: 20, fontWeight: FontWeight.w100),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: DottedBorder(
                        radius: Radius.elliptical(12, 12),
                        color: ColorManager.primary,
                        dashPattern: [10, 10],
                        strokeWidth: 3,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          // width: width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Container(
                                  width: 50, // Adjust the size as needed
                                  height:
                                      50, // Same as width to make it a circle
                                  decoration: BoxDecoration(
                                    shape: BoxShape
                                        .circle, // Makes the container circular
                                  ),
                                  child: Image.asset(
                                      "assets/images/cloudIcon.png")),
                              const SizedBox(height: 8),
                              Text(
                                "Upload un fichier ZIP contenant le projet 3dVista",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w100),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () async {
                                  await controller.pickFile();
                                },
                                child: const Text("Parcourir les fichiers"),
                              ),
                              const SizedBox(height: 4),
                              Obx(() => controller.uploadedFileName.value != ''
                                  ? Center(
                                      child: Text(
                                        "Uploaded file: ${controller.uploadedFileName.value}",
                                        style: TextStyle(fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : SizedBox.shrink()),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    formInput(
                        height: height,
                        label: 'Nom de projet',
                        hint: 'Entrer le nom du projet',
                        inputType: InputType.name,
                        obscureText: false,
                        togglePasswordVisibility: () {}),
                    const SizedBox(height: 20),
                    formInput(
                        height: height,
                        label: 'Localisation',
                        hint: 'Entrer votre localisation',
                        inputType: InputType.name,
                        obscureText: false,
                        togglePasswordVisibility: () {}),
                    const SizedBox(height: 20),
                    Text(
                      'Parametres',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    ListTile(
                      leading: Switch(
                        value: false,
                        onChanged: (value) {},
                      ),
                      title: Text(
                        'Activer le projet ',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ListTile(
                      leading: Switch(
                        value: true,
                        onChanged: (value) {},
                      ),
                      title: Text(
                        'Obliger l’inscription avant de visiter',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Logic to save the project.
                              // controller.toggleView(); // Switches back to the list view.
                            },
                            child: const Text(
                              "Sauvegarder",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                         

                          const SizedBox(width: 10),
                          TextButton(
                            onPressed: () => controller.changeView(ProjectView
                                .list), // Switches back to the list view.
                            child: const Text("Annuler"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProjectDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => controller.changeView(ProjectView.list),
                icon: Icon(Icons.arrow_back),
              ),
              Text(
                "Détails du projet",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          // Add details widgets here...
        ],
      ),
    );
  }

  Widget _buildEditProjectForm(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => controller.changeView(ProjectView.list),
                    icon: Icon(Icons.arrow_back),
                  ),
                  Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.projectName.value,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontSize: 34),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          controller.localisation.value,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.w100),
                        ),
                      ],
                    );
                  }),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: DottedBorder(
                        radius: Radius.elliptical(12, 12),
                        color: ColorManager.primary,
                        dashPattern: [10, 10],
                        strokeWidth: 3,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          // width: width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Container(
                                  width: 50, // Adjust the size as needed
                                  height:
                                      50, // Same as width to make it a circle
                                  decoration: BoxDecoration(
                                    shape: BoxShape
                                        .circle, // Makes the container circular
                                  ),
                                  child: Image.asset(
                                      "assets/images/cloudIcon.png")),
                              const SizedBox(height: 8),
                              Text(
                                "Upload un fichier ZIP contenant le projet 3dVista",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w100),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () async {
                                  await controller.pickFile();
                                },
                                child: const Text("Parcourir les fichiers"),
                              ),
                              const SizedBox(height: 4),
                              Obx(() => controller.uploadedFileName.value != ''
                                  ? Center(
                                      child: Text(
                                        "Uploaded file: ${controller.uploadedFileName.value}",
                                        style: TextStyle(fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : SizedBox.shrink()),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Parametres',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    Obx((){
                      return ListTile(
                        leading: Switch(
                          value: controller.status.value == 'active',
                          onChanged: (value) {
                            controller.status.value =
                                value ? 'active' : 'disactive';
                                print(controller.projectId.value);
                                controller.toggleState.value = value;
                                  
                          },
                        ),
                        title: Text(
                          'Activer le projet',
                          style: TextStyle(fontSize: 14),
                        ),
                      );},
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ListTile(
                      leading: Switch(
                        value: true,
                        onChanged: (value) {},
                      ),
                      title: Text(
                        'Obliger l’inscription avant de visiter',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Obx((){
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                controller.toggleProjectActivation(controller.projectId.value, controller.toggleState.value);
                                // Logic to save the project.
                                // controller.toggleView(); // Switches back to the list view.
                              },
                              child: const Text(
                                "Sauvegarder",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                             const SizedBox(width: 10),
                                 controller.isSLoading.value ?
                            
                              Center(
                                                    child: SizedBox(
                                                        width: 15,
                                                        height: 15,
                                                        child:
                                                            CircularProgressIndicator(
                                                              strokeWidth: 2,
                                                          color: ColorManager.primary,
                                                          backgroundColor:
                                                              Colors.transparent,
                                                        )))
                                                        :SizedBox.shrink(),
                            const SizedBox(width: 10),
                            TextButton(
                              onPressed: () => controller.changeView(ProjectView
                                  .list), // Switches back to the list view.
                              child: const Text("Annuler"),
                            ),
                          ],
                        );}
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
