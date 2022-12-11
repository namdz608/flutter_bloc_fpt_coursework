import 'dart:convert';
import 'package:http/http.dart';
import '../model/Trip.dart';
import 'package:http/http.dart' as http;

class TripFieldAPI {
  List<Trip> listTrips = [];

  Future<Trips> getTrips(int? page) async {
        final String param = 'pagination[page]=${page}';
    final responses = await http
        .get(Uri.parse('http://localhost:1337/api/field-trips?${param}'));
    try {
      Paginate _paginate = Paginate.fromJson(
          json.decode(utf8.decode(responses.bodyBytes))['paginate']);
      print("Lead data : $_paginate"); //tra ve du lieu ok
      listTrips = [];
      (json.decode(utf8.decode(responses.bodyBytes)))['info'].forEach((trips) {
        Trip trip = Trip.fromJson(trips);
        listTrips.add(trip);
      });

      return Trips(info: listTrips, paginate: _paginate);
    } catch (e) {
      print(e);
      throw Exception('Error: ${responses.body}');
    }
  }

  Future<int> addTrip(Trip trip) async {
    final String url = "http://localhost:1337/api/field-trips";
    Response response = await post(
      Uri.parse(url),
      body: json.encode({
        "data": {
          "name": trip.name,
          "description": trip.description,
          "destination": trip.destination,
          "risk_assessment": trip.riskAssessment,
          "date_trip": trip.dateTrip,
          "phone_number":trip.phone,
          "organizational_units":trip.orgUnit
        }
      }),
      headers: <String, String>{"Content-Type": "application/json"},
    );
    print("response: " + response.body);
    return response.statusCode;
  }

  Future<int> deleteTrip(Trip trip) async {
    final url = "http://localhost:1337/api/field-trips/${trip.id}";
    Response response = await delete(
      Uri.parse(url),
    );
      int id = (json.decode(utf8.decode(response.bodyBytes)))['data']['id'];
      return id;
    
  }
}
