import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:proyectocamion/DataHandler/appData.dart';
import 'package:proyectocamion/Models/address.dart';
import '../MapConfig.dart';
import 'requestassistant.dart';


class AssistMethods
{
  static Future<String> searchCoordinateAddress(Position position, context) async
  {
    String placeAddress = "";
    String st1, st2, st3, st4;
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$MapKey";

    var response = await RequestAssistant.getRequest(url);

    if(response != "Conexion fallida.")
      {
        placeAddress = response["results"][0]["formatted_address"];
        st1 = response["results"][0]["formatted_components"][0]["long_name"];
        st2 = response["results"][0]["formatted_components"][4]["long_name"];
        st3 = response["results"][0]["formatted_components"][5]["long_name"];
        st4 = response["results"][0]["formatted_components"][6]["long_name"];
        placeAddress = st1 + ", " +  st2 + ", " +  st3 + ", " +  st4;


        Address userPickUpAddress = Address as Address;
        userPickUpAddress.longitude = position.longitude;
        userPickUpAddress.latitude = position.latitude;
        userPickUpAddress.placeName = placeAddress;

        Provider.of<AppData>(context, listen: false).updatePickUpLocationAddress(userPickUpAddress);
      }


    return placeAddress;
  }
}

