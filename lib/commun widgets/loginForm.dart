import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/loginController.dart';
import 'package:arraid/controllers/navigationCtrl.dart';
import 'package:arraid/screens/HomeScreen/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class loginForm extends StatelessWidget {
  const loginForm({
    super.key,
    required this.height,
    required this.loginController,
    required this.navigationController,
    required this.width,
  });

  final double height;
  final LoginController loginController;
  final NavigationController navigationController;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
          children: <Widget>[
             SizedBox(
            height:height * 0.0532),
            
      
           
         Align(
              alignment: Alignment.centerLeft, // Align text to the left
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
                 
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    
                    borderRadius:
                        BorderRadius.all(Radius.circular(20)),
                        
                  ),
                   prefixIcon:  null,
      
                  labelText: "Your email address",
                  labelStyle: Theme.of(context).textTheme.labelMedium
                  /*  TextStyle(
                        
                      //  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                      ),
                       */
                  ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: height * 0.01),
              Align(
              alignment: Alignment.centerLeft, // Align text to the left
              child: Text(
                " Password",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            SizedBox(height: height * 0.008),
       
         Obx(() =>    TextFormField(
            
              controller: loginController.passwordController,
                obscureText: loginController.obscurePassword.value,
             
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(20)),
                  ),
                  
                  suffixIcon: IconButton(
                  icon: Icon(
                    loginController.obscurePassword.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: loginController.togglePasswordVisibility,
                ),
      
                  labelText: "Your password",
                  labelStyle: Theme.of(context).textTheme.labelMedium
                  /*  TextStyle(
                        
                      //  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                      ),
                       */
                  ),
                  keyboardType: TextInputType.visiblePassword,
            
            )),
            SizedBox(height: height * 0.02),
      
             Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              
              children: [
                Row(
                  children: [
                      Transform.scale(scale: 0.8,
                 child: Switch(
                          value: true,
                          onChanged: (bool value1){},
                        ),
                 ),
                    Text(" Remember me", style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: ColorManager.TextColor,
                        fontWeight: FontWeight.normal,
      
                    )),
                  ],
                ),
            // Align text to the left
      
              TextButton(
                onPressed:(){
                  navigationController.goToForgotPasswordTab();
                } ,
                child: Text(
                      "Forgot password",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ColorManager.primary
                          ),),
              ),
                        
             
      
              ],
            ),
              SizedBox(height: height * 0.037),
           
            SizedBox(
              height: height * 0.0557,
              width: width * 0.8743,
              child: ElevatedButton(
                onPressed:()=> Get.to(Homescreen()),
                child: Text(
                  "SIGN IN",
                
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
            SizedBox(height: height * 0.017),
      
             Center(
               child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(" Do not have an account?", style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            
                              fontWeight: FontWeight.normal,
                   
                          )),
                TextButton(onPressed: (){
                  navigationController.goToSignUpTab();
                }, child: Text(" Sign Up",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ColorManager.primary
                          ),))       
                 ],
               ),
             ),
          
          ],
           
            ),
    );
  }
}