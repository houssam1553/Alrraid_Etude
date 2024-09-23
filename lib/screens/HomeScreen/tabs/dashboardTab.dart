import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/sidebarController.dart';
import 'package:arraid/screens/HomeScreen/widgets/sidebarItem.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({super.key});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> with AutomaticKeepAliveClientMixin {
  late final SidebarController sidebarController;

  late final SideMenuController sideMenuController;

  @override
  void initState() {
    super.initState();
   

    sidebarController = Get.put(SidebarController());
    sideMenuController = SideMenuController(); // Initialize here
  }

  @override
  bool get wantKeepAlive => true; // Keep this state alive when navigating

  @override
  Widget build(BuildContext context) {
         Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    super.build(context); // Ensure state is retained with AutomaticKeepAliveClientMixin
    return  Row(
        children: [
          SideMenu(
            
            title: Column(
              children: [
                Padding(padding: EdgeInsets.only(top:30,bottom: 20,right: 0,), child: Image.asset("assets/images/arraidLogo.png")),
                Divider(indent: 10,endIndent: 10,thickness: 0.5,color: Colors.grey,)
              ],
            ),
            controller: sideMenuController, // Use the initialized controller
            items: [
              SideMenuItem(
                builder: (context, displayMode) {
                  return SidebarItem(
                    index: 0, // Ensure unique index
                    title: 'Dashboard',
                    icon: Icons.home,
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
                    title: 'Settings',
                    icon: Icons.bar_chart_outlined,
                    selectedColor: ColorManager.primary,
                    unselectedColor: Colors.white,
                    sidebarController: sidebarController,
                    children: [
                      SidebarItem(
                        index: 2, // Ensure unique index
                        title: 'User Settings',
                        icon: Icons.person,
                        selectedColor: ColorManager.primary,
                        unselectedColor: Colors.white,
                        sidebarController: sidebarController,
                      ),
                      SidebarItem(
                        index: 3, // Ensure unique index
                        title: 'App Settings',
                        icon: Icons.settings_applications,
                        selectedColor: ColorManager.primary,
                        unselectedColor: Colors.white,
                        sidebarController: sidebarController,
                      ),
                    ],
                  );
                },
              ),
              SideMenuItem(
                builder: (context, displayMode) {
                  return SidebarItem(
                    index: 4, // Ensure unique index
                    title: 'Settings',
                    icon: Icons.settings,
                    selectedColor: ColorManager.primary,
                    unselectedColor: Colors.white,
                    sidebarController: sidebarController,
                    children: [
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
                    ],
                  );
                },
              ),
            ],
            style: SideMenuStyle(
              
              openSideMenuWidth: 200,
              compactSideMenuWidth: width*0.2,
              backgroundColor: ColorManager.greyBack,
            ),
          ),
          Container(
            width: width*0.8,
            color: ColorManager.greyBack,
            child: Column(
              children: [
                Container(
  padding: EdgeInsets.only(top: height * 0.0792, left: 5, ),
  child: Row(
   // mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust alignment here
    children: [
       SearchBar(
          hintText: "Type here...",
          hintStyle: MaterialStateProperty.all<TextStyle?>(Theme.of(context).textTheme.labelMedium),
          textStyle: MaterialStateProperty.all<TextStyle?>(Theme.of(context).textTheme.labelLarge),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.search, color: Colors.grey),
          ),
          constraints: BoxConstraints(maxWidth: 200, maxHeight: 40, minHeight: 40),
          elevation: MaterialStateProperty.all<double?>(0),
        ),
      
       Expanded(
         child: Padding(
           padding: const EdgeInsets.all(12.0),
           child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust alignment for icons
              children: [
                Icon(Icons.person, color: ColorManager.blueGrey),
                Icon(Icons.settings, color: ColorManager.blueGrey),
                Icon(Icons.notifications, color: ColorManager.blueGrey),
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
                    physics: NeverScrollableScrollPhysics(), // Prevent manual swiping if handled by side menu
                    children: [
                      
                    SingleChildScrollView(
                      child: Column(
                          children: [
                            
                            dashboardCard(width: width,title:"Today's users" ,value: "2,300",precentage:  "+5%",),
                         
                      
                            dashboardCard(width: width,title:"Today's users" ,value: "2,300",precentage:  "+5%",),
                            dashboardCard(width: width,title:"Today's users" ,value: "2,300",precentage:  "+5%",),
                           
                          ],
                        ),
                    ),

                      Center(child: Text('Dashboard1')),
                      Center(child: Text('Dashboard2')),
                      Center(child: Text('Settings1')),
                      Center(child: Text('Settings2')),
                      Center(child: Text('Settings3')),

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

class dashboardCard extends StatelessWidget {
  const dashboardCard({
    super.key,
    required this.width, required this.title, required this.value, required this.precentage,
  });
final String title , value, precentage ;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),
        Container(
          width: width*0.7,
          height: 95,
          child: Card(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0), // Add padding inside the card
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the icon and content vertically
                children: [
                  // Left Column (Title and two texts)
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 12,color: ColorManager.greyText), // Title style
                        ),
                        SizedBox(height: 8), // Spacing between title and row of texts
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start, // Align texts to the start
                          children: [
                            Text(
                              value,
                              style: TextStyle(
                                fontSize: 18,color: ColorManager.primary,
                              ), // First text style
                            ),
                            SizedBox(width: 16), // Spacing between the two texts
                            Text(
                             precentage,
                                style: TextStyle(
                                fontSize: 16,color: Colors.green,
                              ), // Second text style
                            ),
                          ],
                        ),
                      ],
                    
                  ),
                  // Right Container with Icon
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: ColorManager.primary, // Background color of icon container
                      //shape: BoxShape.circle, // Make the container circular
                    ),
                    child: Icon(
                      Icons.person, // Replace with your icon
                      color: Colors.white,
                      size: 24, // Adjust icon size
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


