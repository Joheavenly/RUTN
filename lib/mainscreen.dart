import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:proyectocamion/DataHandler/appData.dart';
import 'package:proyectocamion/Divider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:proyectocamion/searchScreen.dart';
import 'Assistants/assistmethods.dart';



class  MainScreen extends StatefulWidget
{
  static const String IDSC = "mainSC";

  @override
  _MainScreenState createState() => _MainScreenState();
}




class _MainScreenState extends State<MainScreen>
{
   final Completer<GoogleMapController> _controllerGoogleMap = Completer();
   late GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

  late Position currentPosition;
  double bottomPaddingMap = 0;


  void locatePosition() async
  {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = new CameraPosition(target: latLatPosition, zoom: 14);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address = await AssistMethods.searchCoordinateAddress(position, context);
    print("Esta es tu ubicacion: " + address);
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.234338179381524, -110.98000661099114),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title:  Text("RUTN", style: TextStyle(fontFamily: "Brand Bold"),),
      ),
      drawer: Container(
        color: Colors.white,
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              //Cabecera
              Container(
                height: 165.0,
                child: DrawerHeader(
                  decoration:  BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Image.asset("images/user_icon.png", height: 65.0, width: 65.0,),
                       SizedBox(width: 16.0,),
                       Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Nombre del perfil", style: TextStyle(fontSize: 16.0, fontFamily: "Brand-Bold"),),
                          SizedBox(height: 6.0,),
                          Text("Ver Perfil", style: TextStyle(fontFamily: "Brand-Bold"),),
                        ],
                      ),
                    ],
                  ),
              ),
          ),
            DividerWidget(),

           SizedBox(height: 12.0,),

               ListTile(
                leading: Icon(Icons.history),
                title: Text("Historial", style: TextStyle(fontSize: 16.0,
                fontFamily: "Brand-Bold"),),
              ),
               ListTile(
                leading: Icon(Icons.person),
                title: Text("Ver perfil", style: TextStyle(fontSize: 16.0,
                    fontFamily: "Brand-Bold"),),
              ),
               ListTile(
                leading: Icon(Icons.info),
                title: Text("Informacion", style: TextStyle(fontSize: 16.0,
                    fontFamily: "Brand-Bold"),),
              ),
          ],
        ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingMap),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller)
            {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              locatePosition();
              setState(()
              {
                bottomPaddingMap = 300.0;
              }
              );
            },
          ),
          //button para el drawer
          Positioned(
            top: 45.0,
            left: 22.0,
            child: GestureDetector(
              onTap: ()
              {
                scaffoldkey.currentState?.openDrawer();
              },
              child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22.0),
                boxShadow:  [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 6.0,
                    spreadRadius: 0.5,
                    offset: Offset(
                      0.7,
                      0.7,
                    ),
                  ),
                ],
              ),
                child:  CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.menu, color: Colors.black,),
                  radius: 20.0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Container(
                height: 300.0,
                  decoration:  BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(18.0)),
                    boxShadow:[
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 16.0,
                        offset: Offset(0.7,0.7),
                      ),
                    ],
                  ),
                child:  Padding(
                  padding:   EdgeInsets.symmetric(horizontal: 18.0,
                      vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     SizedBox(height: 6.0),
                     Text("Hola, ", style: TextStyle(
                        fontSize: 12.0, fontFamily: "Brand-Bold" ),),
                     Text("De donde partes? ", style: TextStyle(fontFamily: "Brand Bold",
                        fontSize: 21.0 ),),
                     SizedBox(height: 20.0),
                    
                    GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen()));
                      },
                      child: Container(
                        decoration:  BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6.0,
                              offset: Offset(0.7,0.7),
                            ),
                          ],
                        ),
                        child:  Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.green,),
                            SizedBox(width: 10.0,),
                              Text("Busca tu punto de partida", style: TextStyle(fontFamily: "Brand-Regular"),)
                            ],
                          ),
                        ),
                      ),
                    ),
                     SizedBox(height: 24.0),
                     Row(
                      children: [
                        Icon(Icons.home, color: Colors.green,),
                        SizedBox(width: 12.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 4.0,),
                              Text(
                                Provider.of<AppData>(context).pickUpLocation?.placeName ??
                                    'Agregar casa'
                                ,
                                style:
                              TextStyle(color: Colors.black54,
                                  fontSize: 12.0, fontFamily: "Brand-Regular"),),
                              Text("Direccion de casa"
                              ),
                            ],
                        ),
                      ],
                    ),

                     SizedBox(height: 10.0),

                    DividerWidget(),

                     SizedBox(height: 10.0),

                     Row(
                      children: [
                        Icon(Icons.work, color: Colors.green,),
                        SizedBox(width: 12.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Agrega punto de bajada", style: TextStyle(
                                fontFamily: "Brand-Regular"),
                            ),
                            SizedBox(height: 4.0,),
                            Text("Tu punto de bajada es: ", style:
                            TextStyle(color: Colors.black54,
                                fontSize: 12.0, fontFamily: "Brand-Regular"),),
                          ],
                        ),
                      ],
                    )
                  ],
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}
