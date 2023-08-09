import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyectocamion/loginscreen.dart';
import 'package:proyectocamion/main.dart';
import 'package:proyectocamion/mainscreen.dart';
import 'package:proyectocamion/progressLoad.dart';

class RegistrationScreen extends StatelessWidget
{
  static const String IDSC = "RegSC";

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController lsnameTextEditingController = TextEditingController();
  TextEditingController adressTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 80.0,),
            const Image(
              image: AssetImage("images/logoCamion.png"),
              width: 180.0,
              height: 120.0,
              alignment: Alignment.center,
            ),

            const SizedBox(height: 20.0,),
            const Text(
              "Registrate como conductor",
              style: TextStyle(fontSize: 24.0, fontFamily: "Brand-Bold"),
              textAlign: TextAlign.center,
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [

                  const SizedBox(height: 1.0,),
                   TextField(
                    controller: nameTextEditingController,
                    keyboardType: TextInputType.text ,
                    decoration: const InputDecoration(
                      labelText: "Nombre(s):",
                      labelStyle: TextStyle(
                          fontSize: 14.0,
                          fontFamily: "Brand Bold"
                      ),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0
                      ),
                    ),
                    style: const TextStyle(fontSize: 14.0, fontFamily: "Brand-Regular"),
                  ),

                  const SizedBox(height: 1.0,),
                   TextField(
                    keyboardType: TextInputType.text,
                    controller: lsnameTextEditingController,
                    decoration: const InputDecoration(
                      labelText: "Apellidos:",
                      labelStyle: TextStyle(
                          fontSize: 14.0,
                          fontFamily: "Brand Bold"
                      ),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0
                      ),
                    ),
                    style: const TextStyle(fontSize: 14.0, fontFamily: "Brand-Regular"),
                  ),
                  const SizedBox(height: 1.0,),
                   TextField(
                    controller: adressTextEditingController,
                    keyboardType: TextInputType.text ,
                    decoration: const InputDecoration(
                      labelText: "Direccion:",
                      labelStyle: TextStyle(
                          fontSize: 14.0,
                          fontFamily: "Brand Bold"
                      ),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0
                      ),
                    ),
                    style: const TextStyle(fontSize: 14.0, fontFamily: "Brand-Regular"),
                  ),

                  const SizedBox(height: 1.0,),
                   TextField(
                    controller: phoneTextEditingController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: "Telefono",
                      labelStyle: TextStyle(
                          fontSize: 14.0,
                          fontFamily: "Brand Bold"
                      ),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0
                      ),
                    ),
                    style: const TextStyle(fontSize: 14.0,fontFamily: "Brand-Regular"),
                  ),

                  const SizedBox(height: 1.0,),
                   TextField(
                    controller: emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Correo/email:",
                      labelStyle: TextStyle(
                          fontSize: 14.0,
                          fontFamily: "Brand Bold"
                      ),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0
                      ),
                    ),
                    style: const TextStyle(fontSize: 14.0, fontFamily: "Brand-Regular"),
                  ),

                  const SizedBox(height: 1.0,),
                   TextField(
                    controller: passwordTextEditingController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password:",
                      labelStyle: TextStyle(
                          fontSize: 14.0,
                          fontFamily: "Brand Bold"
                      ),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0
                      ),
                    ),
                    style: const TextStyle(fontSize: 14.0, fontFamily: "Brand-Regular"),
                  ),

                  const SizedBox(height: 10.0,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                    ),
                    onPressed: () {
                      if(nameTextEditingController.text.length <3 )
                        {
                          displayToastMessage("El nombre debe contener al menos tres (3)  caracteres", context);
                        }
                      else if(lsnameTextEditingController.text.length < 3)
                      {
                        displayToastMessage("El apellido debe contener al menos tres (3)  caracteres", context);
                      }
                      else if(adressTextEditingController.text.isEmpty)
                      {
                        displayToastMessage("La direccion es obligatoria", context);
                      }
                      else if(!emailTextEditingController.text.contains("@"))
                      {
                        displayToastMessage("Este correo/email no es valido", context);
                      }
                      else if(phoneTextEditingController.text.isEmpty)
                      {
                        displayToastMessage("Este campo es obligatorio", context);
                      }
                      else if(passwordTextEditingController.text.length < 6)
                      {
                        displayToastMessage("La contraseña debe contener al menos seis (6) caracteres", context);
                      }
                      else
                        {
                          registerNewUser(context);
                        }
                      registerNewUser(context);
                      print("Inicio de sesion comenzando");
                    },
                    child: Container(
                      height: 50.0,
                      child: const Center(
                        child: Text(
                          "Crear Cuenta",
                          style: TextStyle(fontSize: 18.0, fontFamily:"Brand Bold"),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            TextButton(

              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, LoginScreen.IDSC, (route) => false);

                print("Presionado");
              },
              child: const Text(
                "Ya estabas registrado? Has click aquí", style: TextStyle(fontFamily:
              "Brand Bold", color: Colors.blue),
              ),
            )
          ],
        ),
      ),
    );
  }


  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async
   {
     showDialog(
       context: context,
       barrierDismissible: false,
       builder: (BuildContext context)
       {
         return ProgressLoad("Registrando, por favor espere...",);
       }
   );

    final User = (await _firebaseAuth
        .createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text
    ).catchError((errMsg){
      Navigator.pop(context);
      displayToastMessage("Error: " + errMsg.toString(), context);
    })).user;

    if(User != null)//usuario creado
      {
        //guardar usuario en base de datos
      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "lsname": lsnameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "adress": adressTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
        "password": passwordTextEditingController.text.trim(),
      };

      usersReference.child(User.uid).set(userDataMap);
      displayToastMessage("Genial, tu cuenta ha sido creada", context);

      Navigator.pushNamedAndRemoveUntil(context, LoginScreen.IDSC, (route) => false);
      }
    else{
      Navigator.pop(context);
        //mensaje de error para que se registre correctamente
      displayToastMessage("No se ha creado el nuevo usuario", context);
    }
  }

}


displayToastMessage(String message, BuildContext context)
{
  Fluttertoast.showToast(msg: message);
}

