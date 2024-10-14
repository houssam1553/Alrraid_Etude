import 'package:arraid/commun%20widgets/customInput.dart';
import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/teamController.dart';
import 'package:arraid/models/userListModel.dart';
import 'package:arraid/screens/HomeScreen/widgets/teamCard.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TeamContainer extends StatefulWidget {
  const TeamContainer({
    super.key,
    required this.width,
    required this.height,
    required this.teamController,
  });

  final TeamController teamController;
  final double width;
  final double height;

  @override
  _TeamContainerState createState() => _TeamContainerState();
}

class _TeamContainerState extends State<TeamContainer> {

  @override
  void initState() {
  Userlistmodel  defaultuser =Userlistmodel(id: "id", email: "example", firstName: "thameur", lastName: "alrraid");
    // TODO: implement initState
     widget.teamController.team.isEmpty?widget.teamController.team.value = [defaultuser]:null;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Show big circular progress only during the first data fetch
      if (widget.teamController.isLoading.value && widget.teamController.isFirstFetch.value) {
        return Padding(
          padding: const EdgeInsets.only(top: 180),
          child: Center(
            child: CircularProgressIndicator(
              color: ColorManager.primary,
              backgroundColor: ColorManager.greyText,
            ),
          ),
        );
      }

      return Container(
        width: widget.width * 0.7,
        padding: EdgeInsets.symmetric(horizontal: widget.width * 0.03, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: CustomMaterialIndicator(
          onRefresh: () async {
            // Call the refresh logic to load team members
    await Future.delayed(Duration(seconds: 2)); // Show success animation
            
            await widget.teamController.loadTeamMembers();
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
                    ),
                  );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
            
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Team members",
                    style: TextStyle(
                      fontSize: 18,
                      color: ColorManager.primary,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 10),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.teamController.team.length,
                itemBuilder: (context, index1) {
                  return Obx(() {
                    var user = widget.teamController.team[index1];
                    return TeamCard(
                      index: index1,
                      id: user.id,
                      editCard :widget.teamController.editingCardIndex.value == index1,
                      isTeamPage: true,
                      type: user.type,
                      isExpanded: widget.teamController.expandedCardIndex.value == index1,
                      onTap: widget.teamController.toggleExpand,
                      assetImage: user.imageUrl ?? '',
                      title: '${user.firstName} ${user.lastName}',
                      email: user.email,
                      organization: (user.platforms != null && user.platforms!.length > 1)
                          ? user.platforms![1]
                          : 'Alrraid Pro',
                      subtitle: (user.privileges != null && user.privileges!.isNotEmpty)
                          ? user.privileges![0]
                          : '   user',
                      firstName: user.firstName,
                      lastName: user.lastName,
                       onRefresh: widget.teamController.triggerRefresh,
                    );
                  });
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
