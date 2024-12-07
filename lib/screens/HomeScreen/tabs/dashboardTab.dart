import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/sidebarController.dart';
import 'package:arraid/controllers/tabBarControlller.dart';
import 'package:arraid/screens/HomeScreen/charts/lineChart.dart';
import 'package:arraid/screens/HomeScreen/tabBarTabs/cmndsTab.dart';
import 'package:arraid/screens/HomeScreen/tabBarTabs/devisTab.dart';
import 'package:arraid/screens/HomeScreen/tabBarTabs/projectsTab.dart';
import 'package:arraid/screens/HomeScreen/tabBarTabs/statTab.dart';
import 'package:arraid/screens/HomeScreen/tabBarTabs/viewsTab.dart';
import 'package:arraid/screens/HomeScreen/widgets/dashboardCard.dart';
import 'package:arraid/screens/HomeScreen/widgets/linearChartContiner.dart';
import 'package:arraid/screens/HomeScreen/widgets/projectsTable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({super.key});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab>
    with SingleTickerProviderStateMixin {
  late final SidebarController sidebarController;
  late TabBarController tabBarController;
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    sidebarController = Get.put(SidebarController());
    tabBarController = Get.put(
        TabBarController()); // Adjust the length based on the number of tabs
  }

  @override
  void dispose() {
    sidebarController.selectedIndex.value = 0;
    //tabBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Dashboard',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              Text(
                'admin', // Subtitle
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Define search action here
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // Define more action here
            },
          ),
        ],
        bottom: TabBar(
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          dividerColor: Colors.transparent,
          controller: tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(20), // Rounded corners for t
            color: ColorManager
                .primary, // Primary color or use Theme.of(context).primaryColor
          ),
          indicatorPadding:
              const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          tabs: [
            Tab(
              child: Container(
                // alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 0), // Inner padding
                child: const Text(
                  'Statistiques',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Tab(
              child: Container(
                //alignment: Alignment.centerLeft,

                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 8), // Inner padding
                child: const Text(
                  'Projets',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Tab(
              child: Container(
                //  alignment: Alignment.centerLeft,

                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 8), // Inner padding
                child: const Text(
                  'Commands',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
              Tab(
              child: Container(
                //  alignment: Alignment.centerLeft,

                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 8), // Inner padding
                child: const Text(
                  'Devis',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),  Tab(
              child: Container(
                //  alignment: Alignment.centerLeft,

                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 8), // Inner padding
                child: const Text(
                  'Utilisateurs',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),  
      body: TabBarView(
        controller: tabController,
        children: [
          StatistiquesTab(),
      ProjectsTab(),
         CommandsTab(),
          DevisTab(),
       ViewsTab(),

        ],
      ),
    );
  }

    }