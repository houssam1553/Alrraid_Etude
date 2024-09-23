import 'package:flutter/material.dart';

class ProfileSettingsForm extends StatelessWidget {
  const ProfileSettingsForm({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
                                children: [          SizedBox(height: height * 0.0210
          ),
          
          Align(
       alignment:
           Alignment.centerLeft, // Align text to the left
       child: Text(
         " Name",
         style: Theme.of(context).textTheme.labelLarge,
       ),
                                ),
                                SizedBox(height: height * 0.008),
                                TextFormField(
       //controller: loginController.emailController,
       // validator: (value) => Validator.validateEmail(value), // Use email validator
       decoration: InputDecoration(
           contentPadding: EdgeInsets.symmetric(
               horizontal: 25.0, vertical: 15),
           floatingLabelBehavior: FloatingLabelBehavior.never,
           border: OutlineInputBorder(
             borderRadius:
                 BorderRadius.all(Radius.circular(20)),
                
           ),
           prefixIcon: null,
           labelText: "Zebda Thameur",
           labelStyle: Theme.of(context).textTheme.labelMedium
           /*  TextStyle(
                 
               //  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
               ),
                */
           ),
                                
                                ),
               SizedBox(height: height * 0.0210
          ),
          
          
                                Align(
       alignment:
           Alignment.centerLeft, // Align text to the left
       child: Text(
         " Email",
         style: Theme.of(context).textTheme.labelLarge,
       ),
                                ),
                                SizedBox(height: height * 0.008),
                                TextFormField(
       //controller: loginController.emailController,
       // validator: (value) => Validator.validateEmail(value), // Use email validator
       decoration: InputDecoration(
           contentPadding: EdgeInsets.symmetric(
               horizontal: 25.0, vertical: 15),
           floatingLabelBehavior: FloatingLabelBehavior.never,
           border: OutlineInputBorder(
             borderRadius:
                 BorderRadius.all(Radius.circular(20)),
           ),
           prefixIcon: null,
           labelText: "Your email address",
           labelStyle: Theme.of(context).textTheme.labelMedium
           /*  TextStyle(
                 
               //  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
               ),
                */
           ),
       keyboardType: TextInputType.emailAddress,
                                ),        SizedBox(height: height * 0.0210
          ),
          
          Align(
       alignment:
           Alignment.centerLeft, // Align text to the left
       child: Text(
         " Phone",
         style: Theme.of(context).textTheme.labelLarge,
       ),
                                ),
                                SizedBox(height: height * 0.008),
                                TextFormField(
       
       //controller: loginController.emailController,
       // validator: (value) => Validator.validateEmail(value), // Use email validator
       decoration: InputDecoration(
           contentPadding: EdgeInsets.symmetric(
               horizontal: 25.0, vertical: 15),
           floatingLabelBehavior: FloatingLabelBehavior.never,
           border: OutlineInputBorder(
             borderRadius:
                 BorderRadius.all(Radius.circular(20)),
                
           ),
         
           labelText: " 0777787945",
           labelStyle: Theme.of(context).textTheme.labelMedium
           /*  TextStyle(
                 
               //  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
               ),
                */
           ),
           keyboardType: TextInputType.numberWithOptions(),
                                
                                ),
                                SizedBox(height: height * 0.0210
          ),
          
          Align(
       alignment:
           Alignment.centerLeft, // Align text to the left
       child: Text(
         " Address",
         style: Theme.of(context).textTheme.labelLarge,
       ),
                                ),
                                SizedBox(height: height * 0.008),
                                TextFormField(
       //controller: loginController.emailController,
       // validator: (value) => Validator.validateEmail(value), // Use email validator
       decoration: InputDecoration(
           contentPadding: EdgeInsets.symmetric(
               horizontal: 25.0, vertical: 15),
           floatingLabelBehavior: FloatingLabelBehavior.never,
           border: OutlineInputBorder(
             borderRadius:
                 BorderRadius.all(Radius.circular(20)),
                
           ),
           prefixIcon: null,
           labelText: "38 Bordj El Kiffan , Alger",
           labelStyle: Theme.of(context).textTheme.labelMedium
           /*  TextStyle(
                 
               //  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
               ),
                */
           ),
                                
                                ),
          SizedBox(height: height * 0.04),
            SizedBox(
                    height: height * 0.0557,
                    width: width * 0.823,
                    child: ElevatedButton(
                      onPressed:(){},
                      child: Text(
                        "Apply changes",
                      
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
                  ),
                  SizedBox(   height: height * 0.0357,),

                                ],
                              ),
    );
  }
}
