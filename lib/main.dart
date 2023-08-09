import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectocamion/DataHandler/appData.dart';
import 'package:proyectocamion/loginscreen.dart';
import 'package:proyectocamion/mainscreen.dart';
import 'package:proyectocamion/registrationscreen.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

DatabaseReference usersReference = FirebaseDatabase.instance.reference().child("Usuarios");

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'RUTN',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        initialRoute: RegistrationScreen.IDSC,
        routes: {
          RegistrationScreen.IDSC: (context) => RegistrationScreen(),
          LoginScreen.IDSC: (context) => LoginScreen(),
          MainScreen.IDSC: (context) => MainScreen(),
        }
      ),
    );
  }
}
