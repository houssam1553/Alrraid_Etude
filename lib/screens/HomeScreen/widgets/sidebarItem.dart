import 'package:arraid/controllers/sidebarController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SidebarItem extends StatelessWidget {
  final int index;
  final String title;
  final IconData icon;
  final Color selectedColor;
  final Color unselectedColor;
  final SidebarController sidebarController;
  final List<SidebarItem>? children;

  const SidebarItem({
    Key? key,
    required this.index,
    required this.title,
    required this.icon,
    required this.selectedColor,
    required this.unselectedColor,
    required this.sidebarController,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView( // Use SingleChildScrollView to enable scrolling
        child: Column(
          children: [
            SizedBox(height: 20,),
            Obx(() {
              final isExpanded = sidebarController.expandedIndex.value == index;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      sidebarController.changeIndex(index);
                     
                     sidebarController.selectChildIndex(index);


                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: sidebarController.selectedIndex.value == index
                            ? selectedColor
                            : unselectedColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        icon,
                        color: sidebarController.selectedIndex.value == index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                  AnimatedSize(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: isExpanded && children != null
                        ? Column(
                            children: children!.map((child) {
                              return Column(
                                children: [
                                  SizedBox(height: 15),
                                  GestureDetector(
                                    onTap: () {
                                      sidebarController.selectChildIndex(child.index);
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: sidebarController.selectedIndex.value == child.index
                                            ? selectedColor
                                            : unselectedColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            child.icon,
                                            color: sidebarController.selectedIndex.value == child.index
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          )
                        : SizedBox.shrink(),
                  ),
                ],
              );
            }),
           
          ],
        ),
      ),
    );
  }
}
