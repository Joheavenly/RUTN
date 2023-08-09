import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:proyectocamion/main.dart';
import 'package:proyectocamion/mainscreen.dart';
import 'package:proyectocamion/progressLoad.dart';
import 'package:proyectocamion/registrationscreen.dart';
import 'package:proyectocamion/progressLoad.dart';

class LoginScreen extends StatelessWidget
{
  static const String IDSC = "LogSC";
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
            const SizedBox(height: 120.0,),
            const Image(
              image: AssetImage("images/logoCamion.png"),
              width: 390.0,
              height: 250.0,
              alignment: Alignment.center,
            ),

            const SizedBox(height: 20.0,),
            const Text(
              "Inicia Sesion como conductor",
              style: TextStyle(fontSize: 24.0, fontFamily: "Brand-Bold"),
              textAlign: TextAlign.center,
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [

                   const SizedBox(height: 1.0,),
                   TextField(
                    controller: emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Correo/email:",
                      labelStyle: TextStyle(
                        fontSize: 16.0,
                        fontFamily: "Brand Bold"
                      ),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                          fontFamily: "Brand-Regular"
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
                    onPressed: ()
                    {
                      if(!emailTextEditingController.text.contains("@"))
                      {
                        displayToastMessage("Este correo/email no es valido", context);
                      }
                      else if(passwordTextEditingController.text.isEmpty)
                      {
                        displayToastMessage("La contraseña es obligatoria", context);
                      }
                      else
                        {
                          loginAndAuthenticateUser(context);
                        }
                    },
                    child: Container(
                      height: 50.0,
                      child: const Center(
                        child: Text(
                          "Inicio de sesion",
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
                Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.IDSC, (route) => false);
                print("Presionado");
              },
              child:
              const Text(
                "Aun no tienes una cuenta? Regístrate aquí",
                style: TextStyle(fontFamily:
              "Brand Bold", color: Colors.blue),
              ),
            )
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context) async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressLoad("Verificando informacion, por favor espere...",);
        }
        );

    
    final User = (await _firebaseAuth
        .signInWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text
    ).catchError((errMsg){
      Navigator.pop(context);
      displayToastMessage("Este usuario no esta registrado, por favor crea una cuenta nueva", context);
    })).user;

    if(User != null)
      {
          Navigator.pushNamedAndRemoveUntil(context, MainScreen.IDSC, (route) => false);
          displayToastMessage("Has iniciado sesion.", context);
        }
      else
        {
          Navigator.pop(context);
          _firebaseAuth.signOut();
          displayToastMessage("Este usuario no esta registrado, por favor crea una cuenta nueva", context);
        }
      }
    }


