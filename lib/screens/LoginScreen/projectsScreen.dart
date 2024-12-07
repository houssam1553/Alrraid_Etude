import 'package:arraid/config/colors.dart';
import 'package:arraid/repositories/devisRepo.dart';
import 'package:arraid/screens/LoginScreen/widgets/projectCard.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
// Make sure to import the ProjectsController

class ProjectsScreen extends StatelessWidget {
  final ProjectsController controller = Get.find<ProjectsController>();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nos projets',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              Text(
                'Tous les projets',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Define search action here
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Define more action here
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: 
      
      SingleChildScrollView(
        child: Column(
          children: [
            Obx((){
              return  CustomMaterialIndicator(
                    onRefresh: () async {
                      // Call the refresh logic to load team members
                   // await Future.delayed(Duration(seconds: 2)); // Show success animation
                      
                   await   controller.fetchProjects();
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
                    child: 
                     Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        
                          if (controller.isLoading.value) 
                           
                         
                           Skeletonizer(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount:5,
                      itemBuilder: (BuildContext context, int index){
                             
                                  
                                
                                 
                                  return ProjectCard(
                                  imageUrl: 'assets/images/default.png', // Pass only the thumbnail URL
                          title: 'title',
                          subtitle: 'description',
                          Url: 'url',
                               
                                
                                  );
                                  
                              },
                          )
                          )
                         else 
                            // Obx(() {
                            //   if (controller.projects.isEmpty) {
                            //     // Show loading indicator while fetching projects
                            //     return Center(child: CircularProgressIndicator());
                            //   }
                            //   return 
                            ListView.builder(
                              scrollDirection: Axis.vertical,
              shrinkWrap: true,
                      itemCount: controller.projects.length,
                      itemBuilder: (context, index) {
                        return
                        Obx(() {
                        final project = controller.projects[index];
                        return ProjectCard(
                          imageUrl: 'https://etude.alrraid.com' +  project['thumbnail'], // Pass only the thumbnail URL
                          title: project['title'],
                          subtitle: project['description'],
                          Url: project['url'],
                        );}
                        );
                      },
                              ),
                        ]
                        ),
                     
                
                );
            }
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectsController extends GetxController {
  final DevisRepository devisRepository;
  ProjectsController(this.devisRepository);
  // List of projects
  var projects = <Map<String, dynamic>>[].obs;

  // Constructor to inject DevisRepository
  var isLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
  
    // Fetch projects when the controller is initialized
    fetchProjects();
  }

  // Method to fetch projects from the repository
 Future< void> fetchProjects() async {
   isLoading.value = true;

    try {

      // Fetch the list of projects from the repository
      var fetchedProjects = await devisRepository.fetchProjects();
                             await Future.delayed(Duration(seconds: 1)); // Show success animation

         isLoading.value = false;

      // Update the 'projects' observable with the fetched data
      projects.value = fetchedProjects.map((project) {
        return {
          'thumbnail':  project['thumbnail'],
          'title': project['title'],
          'description': project['description'],
           'url': project['url'],
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
}
