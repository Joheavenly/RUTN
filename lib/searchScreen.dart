import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectocamion/DataHandler/appData.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchSState createState() => _SearchSState();
}

class _SearchSState extends State<SearchScreen>
{
  TextEditingController pickUpTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String placeAddress = Provider.of<AppData>(context).pickUpLocation?.placeName ?? "Agregar Sitio";
    pickUpTextEditingController.text = placeAddress;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 215.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 6.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),

            child:  Padding(
              padding: EdgeInsets.only(left: 25.0, top: 20.0, right: 25.0, bottom: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 50.0),
                   Stack(
                    children: [
                      GestureDetector(
                          onTap: ()
                          {
                            Navigator.pop(context);
                          },
                          child: Icon(
                              Icons.arrow_back
                          ),
                      ),

                      Center(
                        child: Text("Establece punto de partida", style: TextStyle(fontSize: 18.0, fontFamily:  "Brand-Bold"),),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.0),

                  Row(
                    children: [
                      Image.asset("images/pickicon.png", height: 75.0, width: 16.0,),

                      SizedBox(height: 15.0,),

                      Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child:  Padding(
                            padding: EdgeInsets.all(3.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Ubicacion de abordaje",
                              fillColor: Colors.grey[400],
                              filled: true,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.only(left: 75.0, top: 8.0, bottom: 8.0, right: 60.0 ),
                            ),
                          ),
                        ),
                      ),
                      ),
                    ],
                  ),

                  /*SizedBox(height: 10.0),

                  Row(
                    children: [
                      Image.asset("images/desticon.png", height: 16.0, width: 16.0,),

                      SizedBox(height: 18.0,),

                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child:  Padding(
                            padding: EdgeInsets.all(3.0),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Donde subes?",
                                fillColor: Colors.grey[400],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(left: 11.0, top: 8.0, bottom: 8.0 ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}