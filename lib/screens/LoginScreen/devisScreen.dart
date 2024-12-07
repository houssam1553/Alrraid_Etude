import 'package:arraid/commun%20widgets/formInput.dart';
import 'package:arraid/config/colors.dart';
import 'package:arraid/config/enums.dart';
import 'package:arraid/config/validator.dart';
import 'package:arraid/repositories/authRepository.dart';
import 'package:arraid/repositories/devisRepo.dart';
import 'package:arraid/screens/LoginScreen/widgets/projectCard.dart';
import 'package:arraid/services/apiService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class DevisScreen extends StatelessWidget {
  final DevisController controller = Get.find<DevisController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Devis',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Devis approximatif',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Define search action here
              },
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                // Define more action here
              },
            ),
          ],
        ),
        backgroundColor: Colors.grey[200],
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Estimez le devis de votre projet avec notre calculateur intelligent, puis contacter nous pour un devis finale.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                 DropdownButtonFormField<String>(
                value: controller.travail.value.isEmpty ? null : controller.travail.value,
                onChanged: (value) {
                  if (value != null) {
                    controller.travail.value = value;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Travail',
                  hintText: 'Type de travail',
                  border: OutlineInputBorder(),
                ),
                items: ['Amenagement', 'Piscine']
                    .map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner un type de travail';
                  }
                  return null;
                },
              ),
              
                  SizedBox(
                    height: 24,
                  ),
                DropdownButtonFormField<String>(
                value: controller.style.value.isEmpty ? null : controller.style.value,
                onChanged: (value) {
                  if (value != null) {
                    controller.style.value = value;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Style',
                  hintText: 'Style',
                  border: OutlineInputBorder(),
                ),
                items: ['Simple', 'Compliqué']
                    .map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner un style';
                  }
                  return null;
                },
              ),
              
                     SizedBox(
                    height: 10,
                  ),
                  formInput(
                    height: height,
                    label: 'Suface',
                    hint: 'Entrer le surface en m2',
                    inputType: InputType.number,
                    obscureText: false,
                    togglePasswordVisibility: () {},
                    textEditingController: controller.surfaceController,
                  
                  ),
                  SizedBox(
                    height: 10,
                  ),
                                formInput(
                    height: height,
                    label: 'Faces',
                    hint: 'Entrer le nombre des faces',
                    inputType: InputType.number,
                    obscureText: false,
                    togglePasswordVisibility: () {},
                    textEditingController: controller.facesController,
              
                  
                  ),
                  SizedBox(
                    height: 10,
                  ),              formInput(
                    height: height,
                    label: 'Etages',
                    hint: 'Entrer le nombre des etages',
                    inputType: InputType.number,
                    obscureText: false,
                    togglePasswordVisibility: () {},
                    textEditingController: controller.etagesController,
              
                  
                  ),
                  SizedBox(
                    height: 20,
                  ),
                   SizedBox(
                                    height: height * 0.0557,
                                    width: width * 0.63,
                                    child:
                                     Obx(() {
                                      
                                      return
                                       ElevatedButton(
                                      onPressed: () async {
                                                            if (_formKey.currentState!.validate()) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        // Perform your calculation logic here
                    await controller.submitDevis();
                      }
              
                                  //       if (_formKey.currentState!.validate()) {
                                  //         // Trigger logic when the form is valid
              
                                        
                                  //  await       controller.updateUserPassword(userId: controller.currentUser.value!.clerkId , currentPassword: controller. currentPasswordController.text, newPassword:controller. passwordController.text);
              
              
                                  //       }
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Calculer",
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
                                          SizedBox(width: 10),
                                        controller.deviLoad.value
                            ?  Center(
                                                  child: SizedBox(
                                                      width: 15,
                                                      height: 15,
                                                      child:
                                                          CircularProgressIndicator(
                                                            strokeWidth: 2,
                                                        color: ColorManager.white,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                      )))
                            : Icon(Iconsax.document_upload),
                                        ],
                                      ),
                                    
                                  );}),
              
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // formInput(
                  //   height: height,
                  //   label: 'Type',
                  //   hint: 'Type de travail',
                  //   inputType: InputType.multipleChoice,
                  //   obscureText: false,
                  //   togglePasswordVisibility: () {},
                  //   options: ['VR', 'Normal'],
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // formInput(
                  //   height: height,
                  //   label: 'Papiers',
                  //   hint: 'Type de Papiers',
                  //   inputType: InputType.multipleChoice,
                  //   obscureText: false,
                  //   togglePasswordVisibility: () {},
                  //   options: ['Acte', 'Acte + Indivision'],
                  // ),
              ),],
              ),
            ),
          ),
        ));
  }
}
class DevisController extends GetxController {
  final DevisRepository devisRepository;
  final GlobalKey<FormState> _devisFormKey = GlobalKey<FormState>();


  // Controllers for text fields
  final TextEditingController surfaceController = TextEditingController();
  final TextEditingController facesController = TextEditingController();
  final TextEditingController etagesController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

RxBool deviLoad = false.obs;
RxBool cmdLoad = false.obs;

  RxString travail = ''.obs;
  RxString style = ''.obs;

  // Constructor
  DevisController(this.devisRepository);

  // Method to submit devis data
  Future<void> submitDevis() async {
    final data = {
      "surface": surfaceController.text,
      "face": facesController.text,
      "etages": etagesController.text,
      "travail": travail.value,
      "style": style.value,
    };
 deviLoad.value = true; 
    try {

      print("Submitting data: $data");

      // Submit the devis and get the returned result
      final response = await devisRepository.submitDevis(data);

      // Extract the devis and command from the response
      final int devisNumber = response['devis'];
      final command = response['command'];

      // Clear the initial form fields
      surfaceController.clear();
      facesController.clear();
      etagesController.clear();
      travail.value = '';
      style.value = '';
 deviLoad.value = false; 

      // Show dialog to allow the user to update the command
    Get.dialog(
  AlertDialog(
    title: Column(
      children: [
        Text(
          'Devis Estimé',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),Text(
      '$devisNumber DA',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    ),
      ],
    ),
    content: Form(
      key: _devisFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Passer une commande :',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Nom',
              hintText: 'Entrer votre nom',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: numberController,
            keyboardType: TextInputType.phone,
            validator: (value) => Validator.validatePhoneNumber(value),
            decoration: InputDecoration(
              labelText: 'Numéro',
              hintText: 'Entrer votre numéro',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            validator: (value) => Validator.validateEmail(value),
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Entrer votre email',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    ),
    actions: [
      Obx(() {
      
          // Show the button when not loading
          return ElevatedButton(
            onPressed: () async { if(_devisFormKey.currentState!.validate()){
                await updateCommand(command['_id']);
            }
            
            },
            child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Enregistrer'),
                SizedBox(width: 10),
                                      cmdLoad.value
                          ?  Center(
                                                child: SizedBox(
                                                    width: 15,
                                                    height: 15,
                                                    child:
                                                        CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                      color: ColorManager.white,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                    )))
                          : Icon(Iconsax.document_upload),
              ],
            ),
          );
      
      }),
    ],
  ),
);

    } catch (error) {

 deviLoad.value = false; 

      print("Error during submission: $error");
      Get.snackbar(
        'Erreur',
        'Une erreur s\'est produite: $error',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Method to update the command
  Future<void> updateCommand(String commandId) async {
    final updateData = {
     "_id": commandId,
    
        "email": emailController.text, // Add email here if required
        "fullname": nameController.text,
        "phone": numberController.text,
     
    };
 cmdLoad.value = true; 

    try {
      print("Updating command: $updateData");

      // Use the repository to update the command
      await devisRepository.updateCommand(updateData);

      // Close the dialog and clear additional form fields
      Get.back();
      nameController.clear();
      numberController.clear();
 cmdLoad.value = false; 

      // Notify success
     Get.snackbar(
      duration: Duration(seconds: 3),
  'Succès',
  'Commande mise à jour ! \nNous vous contacterons bientôt.',
  snackPosition: SnackPosition.BOTTOM,
);

    } catch (error) {
 cmdLoad.value = false; 

      print("Error during command update: $error");
      Get.snackbar(
        'Erreur',
        'Une erreur s\'est produite: $error',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
