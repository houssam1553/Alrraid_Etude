
import 'package:arraid/config/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class landingScreen extends StatefulWidget {
  @override
  State<landingScreen> createState() => _landingScreenState();
}

class _landingScreenState extends State<landingScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    List<Widget> valuesWidget = [
      
         Card(color: Colors.white,  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
 
 margin: EdgeInsets.all(15),
  elevation: 0,
  child: Padding(
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Stors Overview', // Title of the card
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5),
      
      ],
    ),
  ),
)

          ,
           Card(color: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
  
  margin: EdgeInsets.all(15),
  elevation: 0,
  child: Padding(
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Sales Overview', // Title of the card
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
       
      ],
    ),
  ),
)

          ];
    return Scaffold(
            backgroundColor: ColorManager.lightPrimary,
            
          

      body: SingleChildScrollView(
        child: Center(
          child: 
          Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
             Container(width: width,
              color:Colors.blueGrey.shade100 ,padding: EdgeInsets.symmetric(vertical: 150,horizontal: 15),child:Column(
                children: [
                
                   Image.asset(
                    width: width*0.70,
              'assets/images/landingPic.png',
              fit: BoxFit.cover,
              
            ),
            SizedBox(height: height * 0.0609
        ,),
            Text("NO LIMITS", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.blueGrey.shade600,letterSpacing: 2),),
                    SizedBox(height: height * 0.0209
        ,),
        Text(
          "Unlimited ideas for your projects", 
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.blueGrey.shade900,
            fontSize: 30
          ),
          textAlign: TextAlign.center, // Center the second line
        ),
                 SizedBox(height: height * 0.0209
        ,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Either you want home designs, building design we got unlimited ideas for you to choose from", 
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Colors.blueGrey.shade900,
        fontWeight: FontWeight.normal
            ),
            textAlign: TextAlign.center, // Center the second line
          ),
        ),            SizedBox(height: height * 0.0209
        ,),
        ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "See more",
                  
                     style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(
                          color: Theme.of(context).brightness ==
                                  Brightness.dark
                              ? Colors.black
                              : Colors.white,
                        ), 
                  ),
                  
                ),
        
        
                ],
              ) ,
             ),
              CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
            aspectRatio: 1,
              height: height*0.35,
         //     padEnds: false,
              
             
            ),
            items: 
            valuesWidget,
              
          ),
           
        
            ],
            
          ),
        ),
      ),
    );
  }
}
