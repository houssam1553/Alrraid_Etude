import 'package:arraid/repositories/devisRepo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arraid/config/colors.dart';
import 'package:arraid/screens/HomeScreen/charts/lineChart.dart';
import 'package:arraid/screens/HomeScreen/widgets/dashboardCard.dart';
import 'package:arraid/screens/HomeScreen/widgets/linearChartContiner.dart';
// Import the controller

class StatistiquesTab extends StatelessWidget {
  final StatistiquesController controller = Get.find<StatistiquesController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.lightPrimary,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 14.0, left: 14, right: 14),
              child: LineChartContainer(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                chart: LineChartSample2(),
              ),
            ),
            Obx(() => Padding(
                  padding: const EdgeInsets.only(top: 14.0, left: 14, right: 14),
                  child: dashboardCard(
                    width: MediaQuery.of(context).size.width,
                    title: 'Devis éstimé aujourd’hui',
                    value: controller.estimatedDevisToday.value,
                    precentage: controller.percentageChange.value,
                       icon:  Icon(
                  Icons.monetization_on_rounded, // Replace with your icon
                  color: Colors.white,
                  size: 24, // Adjust icon size
                ),
                  ),
                )),
            Obx(() => Padding(
                  padding: const EdgeInsets.only(top: 14.0, left: 14, right: 14),
                  child: dashboardCard(
                    width: MediaQuery.of(context).size.width,
                    title: 'Commmands aujourd’hui',
                    value: controller.ordersToday.value,
                    precentage: controller.percentageChange.value,
                    icon:  Icon(
                  Icons.arrow_downward, // Replace with your icon
                  color: Colors.white,
                  size: 24, // Adjust icon size
                ),
                  ),
                )),
            Obx(() => Padding(
                  padding: const EdgeInsets.only(top: 14.0, left: 14, right: 14),
                  child: dashboardCard(
                    width: MediaQuery.of(context).size.width,
                    title: 'Nombre du projets',
                    value: controller.projectsNum.value,
                    precentage: controller.percentageChange.value,
                       icon:  Icon(
                  Icons.work, // Replace with your icon
                  color: Colors.white,
                  size: 24, // Adjust icon size
                ),
                  ),
                  
                )),
                SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}


class StatistiquesController extends GetxController {
  // Example observable variables
  var estimatedDevisToday = '...'.obs;
  var ordersToday = '...'.obs;
  var projectsNum = '...'.obs;
  var percentageChange = '+5%'.obs;
   final DevisRepository devisRepository;
  StatistiquesController(this.devisRepository);

  // Fetch data for statistics (simulate API call or database query)
   Future<void> fetchAndCountData() async {
    try {
      final categorizedData = await devisRepository.fetchAndCategorizeCommands();
      final projectsList = await devisRepository.fetchProjects();



      // Safely get lists from the categorized data
      final devisList = categorizedData['devis'] ?? [];
      final commandsList = categorizedData['commands'] ?? [];

      // Update counts
      estimatedDevisToday.value = devisList.length.toString();
      ordersToday.value = commandsList.length.toString();
      projectsNum.value = projectsList.length.toString();

      

  

      print('Devis count: ${estimatedDevisToday.value}');
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchAndCountData(); // Fetch data and count on initialization
  }
}
