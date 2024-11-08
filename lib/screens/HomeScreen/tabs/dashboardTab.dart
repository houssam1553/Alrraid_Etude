import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/sidebarController.dart';
import 'package:arraid/screens/HomeScreen/charts/barChart.dart';
import 'package:arraid/screens/HomeScreen/charts/lineChart.dart';
import 'package:arraid/screens/HomeScreen/pages/dashboardPage.dart';
import 'package:arraid/screens/HomeScreen/pages/teamMembersPage.dart';
import 'package:arraid/screens/HomeScreen/pages/usersPage.dart';
import 'package:arraid/screens/HomeScreen/widgets/barChartContainer.dart';
import 'package:arraid/screens/HomeScreen/widgets/dashboardCard.dart';
import 'package:arraid/screens/HomeScreen/widgets/eventsContainer.dart';
import 'package:arraid/screens/HomeScreen/widgets/linearChartContiner.dart';
import 'package:arraid/screens/HomeScreen/widgets/projectsContainer.dart';
import 'package:arraid/screens/HomeScreen/widgets/sidebarItem.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({super.key});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab>
{
  late final SidebarController sidebarController;



  @override
  void initState() {
    super.initState();
    

    sidebarController = Get.put(SidebarController());
    sidebarController.sideMenuController.dispose();
   // print("sideMenu"+sidebarController.sideMenuController.currentPage.toString());
    
   // sideMenuController = SideMenuController(); 
  
  // sidebarController.selectedIndex =  sideMenuController.currentPage  ;
    // Initialize here
  }
@override
  void dispose() {
    // TODO: implement dispose
    sidebarController.selectedIndex.value = 0;
    super.dispose();
  }
 /*  @override
  bool get wantKeepAlive => true; */ // Keep this state alive when navigating

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    /* super.build(
        context);  */// Ensure state is retained with AutomaticKeepAliveClientMixin
    return Row(
      children: [
        SideMenu(
          collapseWidth: 2000,
          title: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                    top: 30,
                    bottom: 20,
                    right: 0,
                  ),
                  child: Image.asset("assets/images/arraidLogo.png")),
              Divider(
                indent: 10,
                endIndent: 10,
                thickness: 1,
                color:Color(0xFFE2E8F0),
              )
            ],
          ),
          controller:sidebarController.sideMenuController, // Use the initialized controller
          items: [
            SideMenuItem(
              builder: (context, displayMode) {
                return SidebarItem(
                  index: 0, // Ensure unique index
                  title: 'Dashboard',
                  icon: Icons.bar_chart_outlined,
                  selectedColor: ColorManager.primary,
                  unselectedColor: Colors.white,
                  sidebarController: sidebarController,
                );
              },
            ),
            SideMenuItem(
              builder: (context, displayMode) {
                return SidebarItem(
                  index: 1, // Ensure unique index
                  title: 'Users',
                  icon: Icons.person,
                  selectedColor: ColorManager.primary,
                  unselectedColor: Colors.white,
                  sidebarController: sidebarController,
                 
                  
                );
              },
            ),
            SideMenuItem(
              builder: (context, displayMode) {
                return SidebarItem(
                  index: 2, // Ensure unique index
                  title: 'Team members',
                  icon: Icons.work,
                  selectedColor: ColorManager.primary,
                  unselectedColor: Colors.white,
                  sidebarController: sidebarController,
                 /*  children: [
                    SidebarItem(
                      index: 5, // Ensure unique index
                      title: 'User Settings',
                      icon: Icons.person,
                      selectedColor: ColorManager.primary,
                      unselectedColor: Colors.white,
                      sidebarController: sidebarController,
                    ),
                    SidebarItem(
                      index: 6, // Ensure unique index
                      title: 'App Settings',
                      icon: Icons.settings_applications,
                      selectedColor: ColorManager.primary,
                      unselectedColor: Colors.white,
                      sidebarController: sidebarController,
                    ),
                  ], */
                );
              },
            ),
          ],
          style: SideMenuStyle(
            openSideMenuWidth: 200,
            compactSideMenuWidth: width * 0.2,
            backgroundColor: ColorManager.greyBack,
          ),
        ),
        Container(
          width: width * 0.8,
          color: ColorManager.greyBack,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: height * 0.0792,
                  left: 5,
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust alignment here
                  children: [
                    SearchBar(
                      hintText: "Type here...",
                      hintStyle: MaterialStateProperty.all<TextStyle?>(
                          Theme.of(context).textTheme.labelMedium),
                      textStyle: MaterialStateProperty.all<TextStyle?>(
                          Theme.of(context).textTheme.labelLarge),
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.search, color: Colors.grey),
                      ),
                      constraints: BoxConstraints(
                          maxWidth: width*0.42, maxHeight: 40, minHeight: 40),
                      elevation: MaterialStateProperty.all<double?>(0),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Adjust alignment for icons
                          children: [
                            Icon(Icons.person, color: ColorManager.blueGrey),
                            Icon(Icons.settings, color: ColorManager.blueGrey),
                            Icon(Icons.notifications,
                                color: ColorManager.blueGrey),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  controller: sidebarController.pageController,
                  pageSnapping: false,
                  physics:
                      NeverScrollableScrollPhysics(), // Prevent manual swiping if handled by side menu
                  children: [
                    dashboardPage(height: height, width: width),
                                                           UsersPage(height: height, width: width),
                 Teammemberspage(height: height, width: width)
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

