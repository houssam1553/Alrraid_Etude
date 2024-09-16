import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/loginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Logintab extends StatefulWidget {
  const Logintab({super.key});

  @override
  State<Logintab> createState() => _LogintabState();
}

class _LogintabState extends State<Logintab> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    final loginController = Get.put(LoginController());

    return Center(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 120, horizontal: 30),
                child: Form(
                  // key: loginController.loginFormKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Welcome Back",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SizedBox(
                      height:  height * 0.0105,

                      ),
                      Text(
                        "Enter your email and password to signin",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: height * 0.0532),
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
                      SizedBox(height: height * 0.0297),

                       Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        
                        children: [
                          Row(
                            children: [
                               Switch(
                                value: true,
                                onChanged: (value) =>{},
                              ),
                              Text(" Remember me", style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: Colors.black,
                                  fontWeight: FontWeight.normal,

                              )),
                            ],
                          ),
                      // Align text to the left

                        Text(
                              "Forgot password ",
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.primary
                                  ),),
                                  
                       

                        ],
                      ),
                        SizedBox(height: height * 0.04),
                     
                      SizedBox(
                        height: height * 0.0557,
                        width: width * 0.8743,
                        child: ElevatedButton(
                          onPressed: () {},
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
                      SizedBox(height: height * 0.0272),

                       Center(
                         child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(" Do not have an account?", style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      
                                        fontWeight: FontWeight.normal,
                             
                                    )),
                                    Text(
                                " Sign Up",
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: ColorManager.primary
                                    ),),
                                    
                           ],
                         ),
                       ),
                    
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
